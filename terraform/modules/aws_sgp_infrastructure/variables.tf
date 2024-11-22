variable "microservice_name" {
   description = "Microservice name"
}

variable "create_dynamodb" {
  description = "Define se a tabela DynamoDB deve ser criada"
}

variable "create_s3" {
  description = "Define se o bucket S3 deve ser criado"
}
