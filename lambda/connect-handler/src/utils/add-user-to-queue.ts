import { PutCommand } from "@aws-sdk/lib-dynamodb";
import { getDynamoDBDocumentClient } from "../clients";

export const addUserToQueue = async (
  connectionId: string,
  gender?: string,
  preference?: string
) => {
  const dynamoDb = getDynamoDBDocumentClient();
  await dynamoDb.send(
    new PutCommand({
      TableName: process.env.CONNECTIONS_TABLE_NAME!,
      Item: {
        connection_id: connectionId,
        status: "waiting",
        gender: gender || "not_defined",
        preference: preference || "not_defined",
        timestamp: Date.now(),
      },
    })
  );
};
