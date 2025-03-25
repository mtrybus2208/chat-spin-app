output "connections_table_name" {
  value       = aws_dynamodb_table.chat_spin_connections.name
  description = "Name of the DynamoDB connections table"
}

output "connections_table_arn" {
  value       = aws_dynamodb_table.chat_spin_connections.arn
  description = "ARN of the DynamoDB connections table"
}
