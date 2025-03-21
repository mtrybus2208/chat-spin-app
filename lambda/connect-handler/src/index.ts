import { APIGatewayProxyEvent, APIGatewayProxyResult } from "aws-lambda";
import { addUserToQueue } from "./utils";

export const handler = async (
  event: APIGatewayProxyEvent
): Promise<APIGatewayProxyResult> => {
  const { connectionId } = event.requestContext || {};
  const { gender, preference } = event.queryStringParameters || {};

  if (!connectionId) {
    return { statusCode: 400, body: "Wrong connection" };
  }

  try {
    await addUserToQueue(connectionId, gender, preference);
    return { statusCode: 200, body: "Waiting for pair." };
  } catch (error) {
    console.error("Error in connect handler:", error);
    return { statusCode: 500, body: "Internal Server Error" };
  }
};
