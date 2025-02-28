import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocument } from "@aws-sdk/lib-dynamodb";

let cachedClient: DynamoDBClient | null = null;
let cachedDocumentClient: DynamoDBDocument | null = null;

export const getDynamoDBClient = (): DynamoDBClient => {
  if (!cachedClient) {
    cachedClient = new DynamoDBClient({ region: process.env.REGION });
  }
  return cachedClient;
};

export const getDynamoDBDocumentClient = (): DynamoDBDocument => {
  if (!cachedDocumentClient) {
    cachedDocumentClient = DynamoDBDocument.from(getDynamoDBClient());
  }
  return cachedDocumentClient;
};
