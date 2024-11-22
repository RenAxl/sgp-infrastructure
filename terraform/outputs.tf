output "microservice_ec2_public_dns" {
  value = module.aws_sgp_infrastructure.microservice_ec2_public_dns
}

output "microservice_dynamodb_table" {
  value = module.aws_sgp_infrastructure.microservice_dynamodb_table
}

output "microservice_s3_bucket" {
  value = module.aws_sgp_infrastructure.microservice_s3_bucket
}


/*
output "microservice_infrastructure_outputs" {
  value = {
    for microservice, infrastructure in module.aws_sgp_infrastructure :
    microservice => {
      ec2_public_dns = infrastructure.microservice_ec2_public_dns
      dynamodb_table = infrastructure.microservice_dynamodb_table
      s3_bucket      = infrastructure.microservice_s3_bucket
    }
  }
}
*/