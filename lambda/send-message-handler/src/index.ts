import { APIGatewayProxyEvent, APIGatewayProxyResult } from "aws-lambda";
import { GetCommand, GetCommandInput } from "@aws-sdk/lib-dynamodb";
import { getDynamoDBDocumentClient } from "./clients";
import { sendDataToConnection } from "./utils";

export const handler = async (
  event: APIGatewayProxyEvent,
  context: unknown
): Promise<APIGatewayProxyResult> => {
  const connectionId = event.requestContext.connectionId;
  const body = event.body ? JSON.parse(event.body) : {};

  try {
    const dynamoDb = getDynamoDBDocumentClient();
    const command: GetCommandInput = {
      TableName: process.env.CONNECTIONS_TABLE_NAME!,
      Key: {
        connection_id: connectionId || "",
        status: "connected",
      },
    };

    const getResult = await dynamoDb.send(new GetCommand(command));

    if (!getResult.Item) {
      return { statusCode: 404, body: "User not found" };
    }

    const pairedConnectionId = getResult.Item.paired_with;

    await sendDataToConnection(connectionId || "", {
      action: body.action,
      data: {
        message: body.data.message,
        from: connectionId,
        to: connectionId,
      },
    });
    await sendDataToConnection(pairedConnectionId, {
      action: body.action,
      data: {
        message: body.data.message,
        from: connectionId,
        to: pairedConnectionId,
      },
    });

    return {
      statusCode: 200,
      body: JSON.stringify({
        message: "Message sent successfully",
        connectionId,
      }),
    };
  } catch (error) {
    console.error("Error in send message handler:", error);
    return { statusCode: 500, body: "Internal Server Error" };
  }
};
