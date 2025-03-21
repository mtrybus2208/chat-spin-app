data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "chat_spin_api_connect_handler_logging_policy_doc" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = ["arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${aws_lambda_function.chat_spin_api_connect_handler.function_name}:*"]
  }
}

data "aws_iam_policy_document" "chat_spin_api_disconnect_handler_logging_policy_doc" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = ["arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${aws_lambda_function.chat_spin_api_disconnect_handler.function_name}:*"]
  }
}

data "aws_iam_policy_document" "chat_spin_api_send_message_handler_logging_policy_doc" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = ["arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${aws_lambda_function.chat_spin_api_send_message_handler.function_name}:*"]
  }
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# archive_file lambda fn
data "archive_file" "chat_spin_api_connect_handler" {
  type        = "zip"
  source_dir  = "${path.root}/../lambda/connect-handler/dist"
  output_path = "${path.root}/../lambda/connect-handler/build/connect-handler.zip"
}

data "archive_file" "chat_spin_api_disconnect_handler" {
  type        = "zip"
  source_dir  = "${path.root}/../lambda/disconnect-handler/dist"
  output_path = "${path.root}/../lambda/disconnect-handler/build/disconnect-handler.zip"
}
 
data "archive_file" "chat_spin_api_send_message_handler" {
  type        = "zip"
  source_dir  = "${path.root}/../lambda/send-message-handler/dist"
  output_path = "${path.root}/../lambda/send-message-handler/build/send-message-handler.zip"
}

data "archive_file" "chat_spin_api_user_match_handler" {
  type        = "zip"
  source_dir  = "${path.root}/../lambda/user-match-handler/dist"
  output_path = "${path.root}/../lambda/user-match-handler/build/user-match-handler.zip"
}

data "aws_iam_policy_document" "chat_spin_api_user_match_handler_logging_policy_doc" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = ["arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${aws_lambda_function.chat_spin_api_user_match_handler.function_name}:*"]
  }
}