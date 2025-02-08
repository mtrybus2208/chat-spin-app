import { APIGatewayProxyEvent, APIGatewayProxyResult } from "aws-lambda";

export const handler = async (
  event: APIGatewayProxyEvent
): Promise<APIGatewayProxyResult> => {
  console.log("SendMessage handler test log", event);
  return {
    statusCode: 200,
    body: JSON.stringify({ message: "Message sent successfully" }),
  };
};
