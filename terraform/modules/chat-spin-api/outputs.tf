output "api_domain_name" {
  description = "Default domain name for the API Gateway"
  value       = aws_apigatewayv2_api.chat_spin_api.api_endpoint
}
