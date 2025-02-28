import { APIGatewayProxyEvent, APIGatewayProxyResult } from "aws-lambda";
import {
  findAvailableUser,
  connectUsersTransaction,
  addUserToQueue,
  sendDataToConnection,
} from "./utils";

export const handler = async (
  event: APIGatewayProxyEvent
): Promise<APIGatewayProxyResult> => {
  const { connectionId } = event.requestContext || {};
  const { gender, preference } = event.queryStringParameters || {};

  if (!connectionId) {
    return { statusCode: 400, body: "Wrong connection" };
  }

  try {
    const availableUser = await findAvailableUser(gender, preference);
    console.log({
      availableUser,
    });

    if (availableUser) {
      const pairedConnectionId = availableUser.connection_id;

      await connectUsersTransaction(
        {
          connectionId,
          gender,
          preference,
        },
        {
          connectionId: pairedConnectionId,
          gender: availableUser.gender,
          preference: availableUser.preference,
        }
      );

      const roomId = `${connectionId}-${pairedConnectionId}`;

      const message = {
        action: "connected",
        roomId: roomId,
        partner: pairedConnectionId,
      };

      console.log({
        message,
        connectionId,
        pairedConnectionId,
        TEST: 122222,
      });

      await sendDataToConnection(connectionId, message);

      await sendDataToConnection(pairedConnectionId, message);

      return { statusCode: 200, body: "Connected with user." };
    }

    await addUserToQueue(connectionId, gender, preference);
    return { statusCode: 200, body: "Waiting for pair." };
  } catch (error) {
    console.error("Error in connect handler:", error);
    return { statusCode: 500, body: "Internal Server Error" };
  }
};
