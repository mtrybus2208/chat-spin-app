provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Owner = local.prefix
      Name  = local.prefix
    }
  }
}

module "chat-spin-api" {
  source      = "./modules/chat-spin-api"
  environment = local.prefix
  stage       = var.environment
  prefix      = local.prefix
}
# photo_edit_lambda_bucket_name = module.photo_storage.photo_edit_lambda_bucket_name

# user_pool_id                  = module.auth.user_pool_id
# user_pool_endpoint            = module.auth.user_pool_endpoint
# user_pool_client_id           = module.auth.user_pool_client_id
#    image_metadata_table_name     = module.photo_storage.image_metadata_table_name
# image_metadata_table_arn      = module.photo_storage.image_metadata_table_arn
# photo_edit_lambda_bucket_arn  = module.photo_storage.photo_edit_lambda_bucket_arn
# https://kvs-vishnu23.medium.com/understanding-websocket-api-in-amazon-api-gateway-60dc930307c6