resource "random_pet" "bucket_suffix" {
  length = 2
}

resource "aws_s3_bucket" "chat_spin_api_lambda_bucket" {
  bucket = "${var.prefix}-lambda-chat-spin-api-handler-bucket-${random_pet.bucket_suffix.id}"

  force_destroy = true
  lifecycle {
    ignore_changes = [
      cors_rule
    ]
  }
}

resource "aws_s3_bucket_cors_configuration" "bucket_cors_null" {
  bucket = aws_s3_bucket.chat_spin_api_lambda_bucket.id

  cors_rule {
    allowed_methods = ["GET", "PUT"]
    allowed_origins = ["*"]
    allowed_headers = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

# lambda
resource "aws_s3_object" "chat_spin_api_connect_handler" {
  bucket = aws_s3_bucket.chat_spin_api_lambda_bucket.id
  key    = "chat-spin-api-connect-handler.zip"
  source = data.archive_file.chat_spin_api_connect_handler.output_path
  etag   = filemd5(data.archive_file.chat_spin_api_connect_handler.output_path)
}
resource "aws_s3_object" "chat_spin_api_disconnect_handler" {
  bucket = aws_s3_bucket.chat_spin_api_lambda_bucket.id
  key    = "chat-spin-api-disconnect-handler.zip"
  source = data.archive_file.chat_spin_api_disconnect_handler.output_path
  etag   = filemd5(data.archive_file.chat_spin_api_disconnect_handler.output_path)
}

resource "aws_s3_object" "chat_spin_api_send_message_handler" {
  bucket = aws_s3_bucket.chat_spin_api_lambda_bucket.id
  key    = "chat-spin-api-send-message-handler.zip"
  source = data.archive_file.chat_spin_api_send_message_handler.output_path
  etag   = filemd5(data.archive_file.chat_spin_api_send_message_handler.output_path)
}

resource "aws_s3_object" "chat_spin_api_user_match_handler" {
  bucket = aws_s3_bucket.chat_spin_api_lambda_bucket.id
  key    = "chat-spin-api-user-match-handler.zip"
  source = data.archive_file.chat_spin_api_user_match_handler.output_path
  etag   = filemd5(data.archive_file.chat_spin_api_user_match_handler.output_path)
}
