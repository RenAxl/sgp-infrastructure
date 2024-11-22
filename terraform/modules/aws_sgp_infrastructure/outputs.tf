output "microservice_ec2_public_dns" {
  value = aws_instance.microservice_ec2.public_dns
}

output "microservice_dynamodb_table" {
  value = length(aws_dynamodb_table.microservice_dynamodb) > 0 ? aws_dynamodb_table.microservice_dynamodb[0].name : null
}

output "microservice_s3_bucket" {
  value = length(aws_s3_bucket.microservice_s3) > 0 ? aws_s3_bucket.microservice_s3[0].bucket : null
}
