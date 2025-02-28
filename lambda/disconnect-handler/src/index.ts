import {
  GetCommand,
  DeleteCommand,
  BatchWriteCommand,
  QueryCommand,
} from "@aws-sdk/lib-dynamodb";
import { PostToConnectionCommand } from "@aws-sdk/client-apigatewaymanagementapi";
import {
  getDynamoDBDocumentClient,
  getApiGatewayManagementApiClient,
} from "./clients";

export const handler = async (event: any) => {
  console.log(
    "DisConnect handler called with event:",
    JSON.stringify(event, null, 2)
  );

  const connectionId = event.requestContext.connectionId;
  if (!connectionId) {
    console.error("Missing connectionId in event");
    return { statusCode: 400, body: "Missing connectionId" };
  }

  const dynamoDb = getDynamoDBDocumentClient();
  const tableName = process.env.CONNECTIONS_TABLE_NAME as string;

  try {
    // 1. Pobierz informacje o rozłączonym użytkowniku

    const queryResult = await dynamoDb.send(
      new QueryCommand({
        TableName: tableName,
        KeyConditionExpression: "connection_id = :connectionId",
        ExpressionAttributeValues: {
          ":connectionId": connectionId,
        },
      })
    );

    console.log({
      queryResult,
      "queryResult.Items": queryResult.Items,
    });

    if (!queryResult.Items || queryResult.Items.length === 0) {
      console.log(`No user found with connectionId: ${connectionId}`);
      return { statusCode: 200, body: "User was not connected" };
    }

    const [userData] = queryResult.Items;

    if (!userData) {
      console.log(`No connected user found with connectionId: ${connectionId}`);
      return { statusCode: 200, body: "User was not connected" };
    }

    // 2. Usuń rekordy użytkownika
    const batchDeleteParams = {
      RequestItems: {
        [tableName]: [
          {
            DeleteRequest: {
              Key: {
                connection_id: connectionId,
                status: "connected",
              },
            },
          },
          {
            DeleteRequest: {
              Key: {
                connection_id: connectionId,
                status: "waiting",
              },
            },
          },
        ],
      },
    };

    await dynamoDb.send(new BatchWriteCommand(batchDeleteParams));

    // 3. Jeśli użytkownik miał partnera, powiadom go o rozłączeniu
    const pairedWithConnectionId = userData.paired_with;

    if (pairedWithConnectionId) {
      try {
        // Powiadom partnera o rozłączeniu
        await notifyPartnerAboutDisconnection(pairedWithConnectionId);

        // Usuń lub zaktualizuj rekord partnera
        await dynamoDb.send(
          new DeleteCommand({
            TableName: tableName,
            Key: {
              connection_id: pairedWithConnectionId,
              status: "connected",
            },
          })
        );
      } catch (error) {
        console.error("Error handling partner connection:", error);
        // Kontynuuj, nawet jeśli wystąpił błąd z partnerem
      }
    }

    return { statusCode: 200, body: "Disconnection handled successfully" };
  } catch (error) {
    console.error("Error in disconnect handler:", error);
    return { statusCode: 500, body: "Internal server error" };
  }
};

async function notifyPartnerAboutDisconnection(partnerConnectionId: string) {
  try {
    const client = getApiGatewayManagementApiClient();
    const message = {
      type: "DISCONNECTED",
      message: "Your chat partner has disconnected",
    };

    await client.send(
      new PostToConnectionCommand({
        ConnectionId: partnerConnectionId,
        Data: Buffer.from(JSON.stringify(message)),
      })
    );

    console.log(
      `Successfully notified partner ${partnerConnectionId} about disconnection`
    );
  } catch (error: any) {
    if (error.name === "GoneException") {
      console.log(`Partner connection ${partnerConnectionId} already closed`);
    } else {
      console.error(
        `Error sending disconnection notification to ${partnerConnectionId}:`,
        error
      );
      throw error;
    }
  }
}
