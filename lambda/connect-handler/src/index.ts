import { APIGatewayProxyEvent, APIGatewayProxyResult } from "aws-lambda";

export const handler = async (
  event: APIGatewayProxyEvent,
  context: unknown
): Promise<APIGatewayProxyResult> => {
  const connectId = event["requestContext"]["connectionId"];
  const domainName = event["requestContext"]["domainName"];
  const stageName = event["requestContext"]["stage"];
  const qs = event["queryStringParameters"];
  console.log({
    connectId,
    domainName,
    stageName,
    qs,
    context,
    event,
  });
  return { statusCode: 200, body: "OK" };
};

const logRes = {
  connectId: "CfcBmdqZiYcCGOA=",
  domainName: "n6cp5yn4nl.execute-api.us-east-2.amazonaws.com",
  stageName: "dev",
  qs: undefined,
  context: {
    // callbackWaitsForEmptyEventLoop: [Getter/Setter],
    // succeed: [Function (anonymous)],
    // fail: [Function (anonymous)],
    // done: [Function (anonymous)],
    functionVersion: "$LATEST",
    functionName: "mtrybus-chat-spin-api-connect-handler",
    memoryLimitInMB: "128",
    logGroupName: "/aws/lambda/mtrybus-chat-spin-api-connect-handler",
    logStreamName: "2024/12/08/[$LATEST]42f30d322a5a4f18b861548d71406ea6",
    clientContext: undefined,
    identity: undefined,
    invokedFunctionArn:
      "arn:aws:lambda:us-east-2:377226713554:function:mtrybus-chat-spin-api-connect-handler",
    awsRequestId: "bae887fa-b9fe-4a9e-b8f2-cea8e0f4dbef",
    // getRemainingTimeInMillis: [Function: getRemainingTimeInMillis]
  },
  event: {
    headers: {
      "Accept-Encoding": "gzip, deflate, br, zstd",
      "Accept-Language": "en-US,en;q=0.9,de;q=0.8,doi;q=0.7,pl;q=0.6",
      "Cache-Control": "no-cache",
      Host: "n6cp5yn4nl.execute-api.us-east-2.amazonaws.com",
      Origin: "https://websocketking.com",
      Pragma: "no-cache",
      "Sec-WebSocket-Extensions": "permessage-deflate; client_max_window_bits",
      "Sec-WebSocket-Key": "GA622NPyu+7SyK56YPtUyQ==",
      "Sec-WebSocket-Version": "13",
      "User-Agent":
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36",
      "X-Amzn-Trace-Id": "Root=1-67560d3d-6bdbd3ea4ee2f64767399927",
      "X-Forwarded-For": "45.158.109.125",
      "X-Forwarded-Port": "443",
      "X-Forwarded-Proto": "https",
    },
    multiValueHeaders: {
      "Accept-Encoding": [Array],
      "Accept-Language": [Array],
      "Cache-Control": [Array],
      Host: [Array],
      Origin: [Array],
      Pragma: [Array],
      "Sec-WebSocket-Extensions": [Array],
      "Sec-WebSocket-Key": [Array],
      "Sec-WebSocket-Version": [Array],
      "User-Agent": [Array],
      "X-Amzn-Trace-Id": [Array],
      "X-Forwarded-For": [Array],
      "X-Forwarded-Port": [Array],
      "X-Forwarded-Proto": [Array],
    },
    requestContext: {
      routeKey: "$connect",
      eventType: "CONNECT",
      extendedRequestId: "CfcBmERziYcF6Zw=",
      requestTime: "08/Dec/2024:21:18:53 +0000",
      messageDirection: "IN",
      stage: "dev",
      connectedAt: 1733692733092,
      requestTimeEpoch: 1733692733093,
      identity: [Object],
      requestId: "CfcBmERziYcF6Zw=",
      domainName: "n6cp5yn4nl.execute-api.us-east-2.amazonaws.com",
      connectionId: "CfcBmdqZiYcCGOA=",
      apiId: "n6cp5yn4nl",
    },
    isBase64Encoded: false,
  },
};
