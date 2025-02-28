import { APIGatewayProxyEvent, APIGatewayProxyResult } from "aws-lambda";

export const handler = async (
  event: APIGatewayProxyEvent,
  context: unknown
): Promise<APIGatewayProxyResult> => {
  const connectionId = event.requestContext.connectionId;
  const domainName = event.requestContext.domainName;
  const stageName = event.requestContext.stage;
  const body = event.body ? JSON.parse(event.body) : {};

  console.log({
    connectionId,
    domainName,
    stageName,
    body,
    context,
    event,
  });

  return {
    statusCode: 200,
    body: JSON.stringify({
      message: "Message sent successfully",
      connectionId,
    }),
  };
};
