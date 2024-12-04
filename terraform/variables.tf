variable "microservice_name" {
  description = "Nome do microservice"
  type        = string
  default     = "authuser"
}

variable "create_dynamodb" {
  description = "Define se a tabela DynamoDB deve ser criada"
  type        = bool
  default     = true
}

variable "create_s3" {
  description = "Define se o bucket S3 deve ser criado"
  type        = bool
  default     = true
}

variable "region" {
  description = "Nome da região da AWS"
  default     = "us-east-1"
}

/*
// EXEMPLO SE FOSSE CRIAR COMO LISTA
variable "microservice_names" {
  description = "A list of microservice names"
  type        = list(string)
  default     = ["authuser"]
}

variable "create_dynamodb" {
  description = "Define se a tabela DynamoDB deve ser criada"
  type        = list(bool)
  default     = [false]
}

variable "create_s3" {
  description = "Define se o bucket S3 deve ser criado"
  type        = list(bool)
  default     = [false]
}
*/
