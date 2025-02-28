resource "aws_dynamodb_table" "chat_spin_connections" {
  name           = "${var.prefix}-chat-spin-connections"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "connection_id" // partition key
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  range_key      = "status"  // sort key

  attribute {
    name = "connection_id"
    type = "S"
  }

  attribute {
    name = "status"
    type = "S"
  }

  attribute {
    name = "gender"
    type = "S"
  }

  attribute {
    name = "preference"
    type = "S"
  }

 
  # LSI na gender
  local_secondary_index {
    name               = "GenderIndex"
    range_key         = "gender"
    projection_type    = "ALL"
  }

  # LSI na preference
  local_secondary_index {
    name               = "PreferenceIndex"
    range_key         = "preference"
    projection_type    = "ALL"
  }

  # GSI na status
  global_secondary_index {
    name               = "StatusGSI"
    hash_key          = "status"
    projection_type    = "ALL"
  }

  ttl {
    attribute_name = "ttl"
    enabled        = true
  }

  tags = {
    Environment = var.environment
  }
}