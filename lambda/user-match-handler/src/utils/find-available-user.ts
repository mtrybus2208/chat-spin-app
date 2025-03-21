import { QueryCommand, QueryCommandInput } from "@aws-sdk/lib-dynamodb";
import { ChatSpinConnection } from "../../../shared/types";
import { getDynamoDBDocumentClient } from "../clients";

export const findAvailableUser = async (
  connectionId: string,
  gender?: string,
  preference?: string
): Promise<ChatSpinConnection | undefined> => {
  const dynamoDb = getDynamoDBDocumentClient();
  const queryParams: QueryCommandInput = {
    TableName: process.env.CONNECTIONS_TABLE_NAME!,
    IndexName: "StatusGSI",
    ExpressionAttributeNames: {
      "#st": "status",
      "#connId": "connection_id",
    },
    ExpressionAttributeValues: {
      ":stVal": "waiting",
      ":connIdVal": connectionId,
    },
    KeyConditionExpression: "#st = :stVal",
    FilterExpression: "#connId <> :connIdVal",
  };

  const queryResult = await dynamoDb.send(new QueryCommand(queryParams));
  return queryResult.Items?.[0] as ChatSpinConnection | undefined;
};
