provider "aws" {
  region = "us-east-1"
}

module "aws_sgp_infrastructure" {
  source            = "./modules/aws_sgp_infrastructure"
  microservice_name = var.microservice_name
  create_dynamodb   = var.create_dynamodb
  create_s3         = var.create_s3
  region            = var.region
}

/*
 // EXEMPLO SE FOSSE CRIAR COMO LISTA
  //microservice_name = join(", ", [for idx, name in var.microservice_names : "${name}:${var.microservice_names[idx]}"])

// create_dynamodb   = join(", ", [for idx, name in var.microservice_names : "${name}:${var.create_dynamodb[idx]}"])

  //create_s3         = join(", ", [for idx, name in var.microservice_names : "${name}:${var.create_dynamodb[idx]}"])


*/
