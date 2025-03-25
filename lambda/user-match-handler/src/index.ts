import { APIGatewayProxyEvent, APIGatewayProxyResult } from "aws-lambda";
import {
  findAvailableUser,
  connectUsersTransaction,
  sendDataToConnection,
} from "./utils";
import { EventAction } from "../../shared/types";

export const handler = async (
  event: APIGatewayProxyEvent
): Promise<APIGatewayProxyResult> => {
  const { connectionId } = event.requestContext || {};
  const { gender, preference } = event.queryStringParameters || {};

  if (!connectionId) {
    return { statusCode: 400, body: "Wrong connection" };
  }

  try {
    const availableUser = await findAvailableUser(
      connectionId,
      gender,
      preference
    );

    if (!availableUser) {
      return { statusCode: 200, body: "No matching user found." };
    }

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
      action: EventAction.CONNECTED,
      data: {
        roomId: roomId,
        connectionId,
        partner: pairedConnectionId,
      },
    };

    await sendDataToConnection(connectionId, message);
    await sendDataToConnection(pairedConnectionId, message);

    return { statusCode: 200, body: "Connected with user." };
  } catch (error) {
    console.error("Error in user match handler:", error);
    return { statusCode: 500, body: "Internal Server Error" };
  }
};
