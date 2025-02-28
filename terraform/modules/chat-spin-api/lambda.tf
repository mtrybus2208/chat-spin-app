# chat-spin-api-connect-handler fn
resource "aws_lambda_function" "chat_spin_api_connect_handler" {
  function_name    = "${var.prefix}-chat-spin-api-connect-handler"
  s3_bucket        = aws_s3_bucket.chat_spin_api_lambda_bucket.id
  s3_key           = aws_s3_object.chat_spin_api_connect_handler.key
  handler          = "index.handler"
  runtime          = "nodejs20.x"
  role             = aws_iam_role.chat_spin_api_connect_handler_role.arn
  timeout          = 5
  source_code_hash = data.archive_file.chat_spin_api_connect_handler.output_base64sha256

  environment {
    variables = {
  REGION                 = var.region
      CONNECTIONS_TABLE_NAME = var.connections_table_name
      DOMAIN_NAME            = aws_apigatewayv2_api.chat_spin_api.api_endpoint
      STAGE                  = var.stage         
    }
  }
}

resource "aws_cloudwatch_log_group" "chat_spin_api_connect_handler_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.chat_spin_api_connect_handler.function_name}"
  retention_in_days = 30
}

resource "aws_lambda_permission" "allow_apigateway_connect" {
  statement_id  = "AllowAPIGatewayInvokeConnect"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.chat_spin_api_connect_handler.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.chat_spin_api.execution_arn}/*/*"
}


# chat-spin-api-disconnect-handler fn
resource "aws_lambda_function" "chat_spin_api_disconnect_handler" {
  function_name    = "${var.prefix}-chat-spin-api-disconnect-handler"
  s3_bucket        = aws_s3_bucket.chat_spin_api_lambda_bucket.id
  s3_key           = aws_s3_object.chat_spin_api_disconnect_handler.key
  handler          = "index.handler"
  runtime          = "nodejs20.x"
  role             = aws_iam_role.chat_spin_api_disconnect_handler_role.arn
  timeout          = 5
  source_code_hash = data.archive_file.chat_spin_api_disconnect_handler.output_base64sha256

  environment {
    variables = {
      REGION                = var.region
      CONNECTIONS_TABLE_NAME = var.connections_table_name
      DOMAIN_NAME           = aws_apigatewayv2_api.chat_spin_api.api_endpoint
      STAGE                 = var.stage
    }
  }
}

resource "aws_cloudwatch_log_group" "chat_spin_api_disconnect_handler_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.chat_spin_api_disconnect_handler.function_name}"
  retention_in_days = 30
}


resource "aws_lambda_permission" "allow_apigateway_disconnect" {
  statement_id  = "AllowAPIGatewayInvokeConnect"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.chat_spin_api_disconnect_handler.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.chat_spin_api.execution_arn}/*/*"
}

# chat-spin-api-send-message-handler fn
resource "aws_lambda_function" "chat_spin_api_send_message_handler" {
  function_name    = "${var.prefix}-chat-spin-api-send-message-handler"
  s3_bucket        = aws_s3_bucket.chat_spin_api_lambda_bucket.id
  s3_key           = aws_s3_object.chat_spin_api_send_message_handler.key
  handler          = "index.handler"
  runtime          = "nodejs20.x"
  role             = aws_iam_role.chat_spin_api_send_message_handler_role.arn
  timeout          = 5
  source_code_hash = data.archive_file.chat_spin_api_send_message_handler.output_base64sha256

  environment {
    variables = {
      REGION                = var.region
      CONNECTIONS_TABLE_NAME = var.connections_table_name
      DOMAIN_NAME           = aws_apigatewayv2_api.chat_spin_api.api_endpoint
      STAGE                 = var.stage
    }
  }
}

resource "aws_cloudwatch_log_group" "chat_spin_api_send_message_handler_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.chat_spin_api_send_message_handler.function_name}"
  retention_in_days = 30
}

resource "aws_lambda_permission" "allow_apigateway_send_message" {
  statement_id  = "AllowAPIGatewayInvokeSendMessage"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.chat_spin_api_send_message_handler.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.chat_spin_api.execution_arn}/*/*"
}