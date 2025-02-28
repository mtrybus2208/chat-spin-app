import { TransactWriteCommand } from "@aws-sdk/lib-dynamodb";
import { getDynamoDBClient } from "../clients";

interface UserConnectionData {
  connectionId: string;
  gender?: string;
  preference?: string;
}

export const connectUsersTransaction = async (
  user1: UserConnectionData,
  user2: UserConnectionData
) => {
  const client = getDynamoDBClient();
  const timestamp = Date.now();

  const transactParams = {
    TransactItems: [
      {
        // Usuń stary rekord dla pierwszego użytkownika
        Delete: {
          TableName: process.env.CONNECTIONS_TABLE_NAME!,
          Key: {
            connection_id: user1.connectionId,
            status: "waiting",
          },
        },
      },
      {
        // Wstaw nowy rekord dla pierwszego użytkownika
        Put: {
          TableName: process.env.CONNECTIONS_TABLE_NAME!,
          Item: {
            connection_id: user1.connectionId,
            status: "connected",
            gender: user1.gender || "not_defined",
            preference: user1.preference || "not_defined",
            paired_with: user2.connectionId,
            timestamp: timestamp,
          },
        },
      },
      {
        // Usuń stary rekord dla drugiego użytkownika
        Delete: {
          TableName: process.env.CONNECTIONS_TABLE_NAME!,
          Key: {
            connection_id: user2.connectionId,
            status: "waiting",
          },
        },
      },
      {
        // Wstaw nowy rekord dla drugiego użytkownika
        Put: {
          TableName: process.env.CONNECTIONS_TABLE_NAME!,
          Item: {
            connection_id: user2.connectionId,
            status: "connected",
            gender: user2.gender || "not_defined",
            preference: user2.preference || "not_defined",
            paired_with: user1.connectionId,
            timestamp: timestamp,
          },
        },
      },
    ],
  };

  await client.send(new TransactWriteCommand(transactParams));
};
