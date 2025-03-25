# gw definition
resource "aws_apigatewayv2_api" "chat_spin_api" {
  name                       = "${var.prefix}-chat-spin-websocket"
  protocol_type              = "WEBSOCKET"
  route_selection_expression = "$request.body.action"
}

# connect route
resource "aws_apigatewayv2_route" "chat_spin_api_connect_route" {
  api_id    = aws_apigatewayv2_api.chat_spin_api.id
  route_key = "$connect"
  target    = "integrations/${aws_apigatewayv2_integration.connect_integration.id}"
}


resource "aws_apigatewayv2_integration" "connect_integration" {
  api_id             = aws_apigatewayv2_api.chat_spin_api.id
  integration_type   = "AWS_PROXY"
  integration_uri    = aws_lambda_function.chat_spin_api_connect_handler.invoke_arn
  integration_method = "POST"
}


# disconnect route
resource "aws_apigatewayv2_route" "chat_spin_api_disconnect_route" {
  api_id    = aws_apigatewayv2_api.chat_spin_api.id
  route_key = "$disconnect"
  target    = "integrations/${aws_apigatewayv2_integration.disconnect_integration.id}"
}

resource "aws_apigatewayv2_integration" "disconnect_integration" {
  api_id             = aws_apigatewayv2_api.chat_spin_api.id
  integration_type   = "AWS_PROXY"
  integration_uri    = aws_lambda_function.chat_spin_api_disconnect_handler.invoke_arn
  integration_method = "POST"
}

# stage
resource "aws_apigatewayv2_stage" "default_stage" {
  api_id      = aws_apigatewayv2_api.chat_spin_api.id
  name        = var.stage
  auto_deploy = true

  lifecycle {
    create_before_destroy = true
  }
}

# sendMessage route
resource "aws_apigatewayv2_route" "chat_spin_api_send_message_route" {
  api_id    = aws_apigatewayv2_api.chat_spin_api.id
  route_key = "sendMessage"
  target    = "integrations/${aws_apigatewayv2_integration.send_message_integration.id}"
}

resource "aws_apigatewayv2_integration" "send_message_integration" {
  api_id             = aws_apigatewayv2_api.chat_spin_api.id
  integration_type   = "AWS_PROXY"
  integration_uri    = aws_lambda_function.chat_spin_api_send_message_handler.invoke_arn
  integration_method = "POST"
}

# userMatch route
resource "aws_apigatewayv2_route" "chat_spin_api_user_match_route" {
  api_id    = aws_apigatewayv2_api.chat_spin_api.id
  route_key = "userMatch"
  target    = "integrations/${aws_apigatewayv2_integration.user_match_integration.id}"
}

resource "aws_apigatewayv2_integration" "user_match_integration" {
  api_id             = aws_apigatewayv2_api.chat_spin_api.id
  integration_type   = "AWS_PROXY"
  integration_uri    = aws_lambda_function.chat_spin_api_user_match_handler.invoke_arn
  integration_method = "POST"
}