import { PostToConnectionCommand } from "@aws-sdk/client-apigatewaymanagementapi";
import { getApiGatewayManagementApiClient } from "../clients";

export const sendDataToConnection = async (
  connectionId: string,
  message: any
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
      console.log(`Connection ${connectionId} is gone, cleaning up`);
      // Tutaj możesz dodać logikę czyszczenia
      return false;
    }

    return false;
  }
};

// https://kvs-vishnu23.medium.com/understanding-websocket-api-in-amazon-api-gateway-60dc930307c6
