import {
  DeleteCommand,
  BatchWriteCommand,
  QueryCommand,
} from "@aws-sdk/lib-dynamodb";

import { getDynamoDBDocumentClient } from "./clients";
import { sendDataToConnection } from "./utils";
import { EventAction } from "../../shared/types";
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
    const queryResult = await dynamoDb.send(
      new QueryCommand({
        TableName: tableName,
        ExpressionAttributeNames: {
          "#connId": "connection_id",
        },
        KeyConditionExpression: "#connId = :connectionId",
        ExpressionAttributeValues: {
          ":connectionId": connectionId,
        },
      })
    );

    if (!queryResult.Items || !queryResult.Items.length) {
      console.log(`No user found with connectionId: ${connectionId}`);
      return { statusCode: 200, body: "User was not connected" };
    }

    const [userData] = queryResult.Items;

    if (!userData) {
      console.log(`No connected user found with connectionId: ${connectionId}`);
      return { statusCode: 200, body: "User was not connected" };
    }

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

    const pairedWithConnectionId = userData.paired_with;

    if (pairedWithConnectionId) {
      try {
        await sendDataToConnection(pairedWithConnectionId, {
          action: EventAction.DISCONNECTED,
          data: {
            message: "Your chat partner has disconnected",
          },
        });

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
      }
    }

    return { statusCode: 200, body: "Disconnection handled successfully" };
  } catch (error) {
    console.error("Error in disconnect handler:", error);
    return { statusCode: 500, body: "Internal server error" };
  }
};
