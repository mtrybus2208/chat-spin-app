# chat_spin_api_connect_handler

resource "aws_iam_policy" "chat_spin_api_connect_handler_logging_policy" {
  description = "IAM policy allowing logging actions for connect handler lambda function."

  name   = "${var.prefix}-chat-spin-api-connect-handler-logging-policy"
  policy = data.aws_iam_policy_document.chat_spin_api_connect_handler_logging_policy_doc.json
}

resource "aws_iam_role" "chat_spin_api_connect_handler_role" {
  name               = "${var.prefix}-chat-spin-api-connect-handler"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "chat_spin_api_connect_handler_logging_policy_attachment" {
  role       = aws_iam_role.chat_spin_api_connect_handler_role.name
  policy_arn = aws_iam_policy.chat_spin_api_connect_handler_logging_policy.arn
}

# gw lambda policy connect
data "aws_iam_policy_document" "chat_spin_api_connect_handler_policy_doc" {
  statement {
    effect = "Allow"
    actions = [
      "apigateway:POST",
      "apigateway:GET",
      "apigateway:PUT"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "chat_spin_api_connect_handler_policy" {
  name   = "${var.prefix}-chat-spin-api-connect-handler-policy"
  policy = data.aws_iam_policy_document.chat_spin_api_connect_handler_policy_doc.json
}

resource "aws_iam_role_policy_attachment" "chat_spin_api_connect_handler_policy_attachment" {
  role       = aws_iam_role.chat_spin_api_connect_handler_role.name
  policy_arn = aws_iam_policy.chat_spin_api_connect_handler_policy.arn
}

# chat_spin_api_disconnect_handler
resource "aws_iam_policy" "chat_spin_api_disconnect_handler_logging_policy" {
  description = "IAM policy allowing logging actions for disconnect handler lambda function."

  name   = "${var.prefix}-chat-spin-api-disconnect-handler-logging-policy"
  policy = data.aws_iam_policy_document.chat_spin_api_disconnect_handler_logging_policy_doc.json
}

resource "aws_iam_role" "chat_spin_api_disconnect_handler_role" {
  name               = "${var.prefix}-chat-spin-api-disconnect-handler"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}


# gw lambda policy disconnect
data "aws_iam_policy_document" "chat_spin_api_disconnect_handler_policy_doc" {
  statement {
    effect = "Allow"
    actions = [
      "apigateway:POST",
      "apigateway:GET",
      "apigateway:PUT"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "chat_spin_api_disconnect_handler_policy" {
  name   = "${var.prefix}-chat-spin-api-disconnect-handler-policy"
  policy = data.aws_iam_policy_document.chat_spin_api_disconnect_handler_policy_doc.json
}

resource "aws_iam_role_policy_attachment" "chat_spin_api_disconnect_handler_policy_attachment" {
  role       = aws_iam_role.chat_spin_api_disconnect_handler_role.name
  policy_arn = aws_iam_policy.chat_spin_api_disconnect_handler_policy.arn
}

# chat_spin_api_send_message_handler
resource "aws_iam_policy" "chat_spin_api_send_message_handler_logging_policy" {
  description = "IAM policy allowing logging actions for send message handler lambda function."
  name        = "${var.prefix}-chat-spin-api-send-message-handler-logging-policy"
  policy      = data.aws_iam_policy_document.chat_spin_api_send_message_handler_logging_policy_doc.json
}
resource "aws_iam_role" "chat_spin_api_send_message_handler_role" {
  name               = "${var.prefix}-chat-spin-api-send-message-handler"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "chat_spin_api_send_message_handler_logging_policy_attachment" {
  role       = aws_iam_role.chat_spin_api_send_message_handler_role.name
  policy_arn = aws_iam_policy.chat_spin_api_send_message_handler_logging_policy.arn
}

# gw lambda policy send message
data "aws_iam_policy_document" "chat_spin_api_send_message_handler_policy_doc" {
  statement {
    effect = "Allow"
    actions = [
      "apigateway:POST",
      "apigateway:GET",
      "apigateway:PUT"
    ]
    resources = [
      "*"
    ]
  }
}
resource "aws_iam_policy" "chat_spin_api_send_message_handler_policy" {
  name   = "${var.prefix}-chat-spin-api-send-message-handler-policy"
  policy = data.aws_iam_policy_document.chat_spin_api_send_message_handler_policy_doc.json
}

resource "aws_iam_role_policy_attachment" "chat_spin_api_send_message_handler_policy_attachment" {
  role       = aws_iam_role.chat_spin_api_send_message_handler_role.name
  policy_arn = aws_iam_policy.chat_spin_api_send_message_handler_policy.arn
}
