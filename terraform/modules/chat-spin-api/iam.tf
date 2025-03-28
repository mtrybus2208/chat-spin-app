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

resource "aws_iam_role_policy_attachment" "chat_spin_api_disconnect_handler_logging_policy_attachment" {
  role       = aws_iam_role.chat_spin_api_disconnect_handler_role.name
  policy_arn = aws_iam_policy.chat_spin_api_disconnect_handler_logging_policy.arn
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

# Dodaj do istniejących polityk

data "aws_iam_policy_document" "dynamodb_access" {
  statement {
    effect = "Allow"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "dynamodb:DeleteItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:BatchWriteItem"
    ]
    resources = [
      var.connections_table_arn,
      "${var.connections_table_arn}/index/*"
    ]
  }
}

resource "aws_iam_policy" "dynamodb_access" {
  name   = "${var.prefix}-chat-spin-api-dynamodb-access"
  policy = data.aws_iam_policy_document.dynamodb_access.json
}

resource "aws_iam_role_policy_attachment" "connect_handler_dynamodb" {
  role       = aws_iam_role.chat_spin_api_connect_handler_role.name
  policy_arn = aws_iam_policy.dynamodb_access.arn
}

resource "aws_iam_role_policy_attachment" "disconnect_handler_dynamodb" {
  role       = aws_iam_role.chat_spin_api_disconnect_handler_role.name
  policy_arn = aws_iam_policy.dynamodb_access.arn
}

resource "aws_iam_role_policy_attachment" "send_message_handler_dynamodb" {
  role       = aws_iam_role.chat_spin_api_send_message_handler_role.name
  policy_arn = aws_iam_policy.dynamodb_access.arn
}

# policy for api gateway management api send msgs
# policy for api gateway management api send msgs
data "aws_iam_policy_document" "websocket_management_policy_doc" {
  statement {
    effect = "Allow"
    actions = [
      "execute-api:ManageConnections"
    ]
    resources = [
      "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:${aws_apigatewayv2_api.chat_spin_api.id}/${var.stage}/POST/@connections/*"
    ]
  }
}

resource "aws_iam_policy" "websocket_management_policy" {
  name   = "${var.prefix}-websocket-management-policy"
  policy = data.aws_iam_policy_document.websocket_management_policy_doc.json
}

# attach policy to lambda roles
resource "aws_iam_role_policy_attachment" "connect_handler_websocket_management" {
  role       = aws_iam_role.chat_spin_api_connect_handler_role.name
  policy_arn = aws_iam_policy.websocket_management_policy.arn
}

resource "aws_iam_role_policy_attachment" "disconnect_handler_websocket_management" {
  role       = aws_iam_role.chat_spin_api_disconnect_handler_role.name
  policy_arn = aws_iam_policy.websocket_management_policy.arn
}

# chat_spin_api_user_match_handler
resource "aws_iam_policy" "chat_spin_api_user_match_handler_logging_policy" {
  description = "IAM policy allowing logging actions for user match handler lambda function."
  name        = "${var.prefix}-chat-spin-api-user-match-handler-logging-policy"
  policy      = data.aws_iam_policy_document.chat_spin_api_user_match_handler_logging_policy_doc.json
}

resource "aws_iam_role" "chat_spin_api_user_match_handler_role" {
  name               = "${var.prefix}-chat-spin-api-user-match-handler"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "chat_spin_api_user_match_handler_logging_policy_attachment" {
  role       = aws_iam_role.chat_spin_api_user_match_handler_role.name
  policy_arn = aws_iam_policy.chat_spin_api_user_match_handler_logging_policy.arn
}

# gw lambda policy user match
data "aws_iam_policy_document" "chat_spin_api_user_match_handler_policy_doc" {
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

resource "aws_iam_policy" "chat_spin_api_user_match_handler_policy" {
  name   = "${var.prefix}-chat-spin-api-user-match-handler-policy"
  policy = data.aws_iam_policy_document.chat_spin_api_user_match_handler_policy_doc.json
}

resource "aws_iam_role_policy_attachment" "chat_spin_api_user_match_handler_policy_attachment" {
  role       = aws_iam_role.chat_spin_api_user_match_handler_role.name
  policy_arn = aws_iam_policy.chat_spin_api_user_match_handler_policy.arn
}


resource "aws_iam_role_policy_attachment" "user_match_handler_dynamodb" {
  role       = aws_iam_role.chat_spin_api_user_match_handler_role.name
  policy_arn = aws_iam_policy.dynamodb_access.arn
}


resource "aws_iam_role_policy_attachment" "user_match_handler_websocket_management" {
  role       = aws_iam_role.chat_spin_api_user_match_handler_role.name
  policy_arn = aws_iam_policy.websocket_management_policy.arn
}


resource "aws_iam_role_policy_attachment" "send_message_handler_websocket_management" {
  role       = aws_iam_role.chat_spin_api_send_message_handler_role.name
  policy_arn = aws_iam_policy.websocket_management_policy.arn
}