resource "aws_security_group" "microservice_ec2_sg" {
  name        = "sgp-${var.microservice_name}-ec2-sg"
  description = "Allow traffic on ports 22 and 80"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sgp-${var.microservice_name}"
  }
}

resource "aws_instance" "microservice_ec2" {
  ami                    = "ami-007855ac798b5175e"
  instance_type          = "t2.micro"
  key_name               = "sgp-ec2-key"
  vpc_security_group_ids = [aws_security_group.microservice_ec2_sg.id]

  tags = {
    Name = "sgp-${var.microservice_name}"
  }
}


resource "aws_dynamodb_table" "microservice_dynamodb" {
  count        = var.create_dynamodb ? 1 : 0
  name         = "sgp-${var.microservice_name}-dynamodb"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name = "sgp-${var.microservice_name}"
  }
}

resource "random_string" "bucket_suffix" {
  length  = 4
  special = false
  upper   = false
}

resource "aws_s3_bucket" "microservice_s3" {
  count  = var.create_s3 ? 1 : 0
  bucket = "sgp-${var.microservice_name}-s3-${random_string.bucket_suffix.result}"

  tags = {
    Name = "sgp-${var.microservice_name}"
  }
}
