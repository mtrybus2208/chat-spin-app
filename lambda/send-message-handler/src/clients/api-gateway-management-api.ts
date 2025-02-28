import { ApiGatewayManagementApiClient } from "@aws-sdk/client-apigatewaymanagementapi";

let cachedClient: ApiGatewayManagementApiClient | null = null;

export const getApiGatewayManagementApiClient =
  (): ApiGatewayManagementApiClient => {
    if (!cachedClient) {
      const domainName = process.env.DOMAIN_NAME!;
      const stage = process.env.STAGE!;

      console.log({
        domainName,
      });

      cachedClient = new ApiGatewayManagementApiClient({
        endpoint: `https://${domainName}/${stage}`,
        region: process.env.REGION,
      });
    }
    return cachedClient;
  };
