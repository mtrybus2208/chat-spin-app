import { QueryCommand, QueryCommandInput } from "@aws-sdk/lib-dynamodb";
import { ChatSpinConnection } from "../../../shared/types";
import { getDynamoDBDocumentClient } from "../clients";

export const findAvailableUser = async (
  gender?: string,
  preference?: string
): Promise<ChatSpinConnection | undefined> => {
  const dynamoDb = getDynamoDBDocumentClient();
  const queryParams: QueryCommandInput = {
    TableName: process.env.CONNECTIONS_TABLE_NAME!,
    IndexName: "StatusGSI",
    KeyConditionExpression: "#status = :status",
    ExpressionAttributeNames: {
      "#status": "status",
    },
    ExpressionAttributeValues: {
      ":status": "waiting",
    },
  };

  const filterExpressions: string[] = [];
  const filterNames: Record<string, string> = {};
  const filterValues: Record<string, string> = {};

  if (preference) {
    filterExpressions.push("#gender = :prefValue");
    filterNames["#gender"] = "gender";
    filterValues[":prefValue"] = preference;
  }

  if (gender) {
    filterExpressions.push("#preference = :genderValue");
    filterNames["#preference"] = "preference";
    filterValues[":genderValue"] = gender;
  }

  if (filterExpressions.length > 0) {
    queryParams.FilterExpression = filterExpressions.join(" AND ");
    queryParams.ExpressionAttributeNames = {
      ...queryParams.ExpressionAttributeNames,
      ...filterNames,
    };
    queryParams.ExpressionAttributeValues = {
      ...queryParams.ExpressionAttributeValues,
      ...filterValues,
    };
  }

  const queryResult = await dynamoDb.send(new QueryCommand(queryParams));
  return queryResult.Items?.[0] as ChatSpinConnection | undefined;
};
