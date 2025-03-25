import { ApiGatewayManagementApiClient } from "@aws-sdk/client-apigatewaymanagementapi";

let cachedClient: ApiGatewayManagementApiClient | null = null;

export const getApiGatewayManagementApiClient =
  (): ApiGatewayManagementApiClient => {
    if (!cachedClient) {
      const domainNameWithProtocol = process.env.DOMAIN_NAME!;
      const domainName = domainNameWithProtocol.substring(6);
      const stage = process.env.STAGE!;

      cachedClient = new ApiGatewayManagementApiClient({
        endpoint: `https://${domainName}/${stage}`,
        region: process.env.REGION,
      });
    }
    return cachedClient;
  };
