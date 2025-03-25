import { PostToConnectionCommand } from "@aws-sdk/client-apigatewaymanagementapi";
import { getApiGatewayManagementApiClient } from "../clients";
import { SocketMessage } from "../../../shared/types";

export const sendDataToConnection = async (
  connectionId: string,
  message: SocketMessage
): Promise<boolean> => {
  const client = getApiGatewayManagementApiClient();

  const command = new PostToConnectionCommand({
    ConnectionId: connectionId,
    Data: JSON.stringify(message),
  });

  try {
    console.log(`Sending message to ${connectionId}:`, message);
    await client.send(command);
    console.log(`Message successfully sent to ${connectionId}`);
    return true;
  } catch (error: any) {
    console.error(`Error sending message to ${connectionId}:`, error);

    if (error.name === "GoneException") {
      return false;
    }

    return false;
  }
};
