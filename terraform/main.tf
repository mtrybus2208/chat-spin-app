provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Owner = local.prefix
      Name  = local.prefix
    }
  }
}

module "chat-spin-storage" {
  source      = "./modules/chat-spin-storage"
  environment = local.prefix
  prefix      = local.prefix
}

module "chat-spin-api" {
  source      = "./modules/chat-spin-api"
  environment = local.prefix
  stage       = var.environment
  prefix      = local.prefix

  connections_table_name = module.chat-spin-storage.connections_table_name
  connections_table_arn  = module.chat-spin-storage.connections_table_arn
}