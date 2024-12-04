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
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
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
  iam_instance_profile   = aws_iam_instance_profile.s3_dynamodb_full_access_instance_profile.name

  provisioner "local-exec" {
    command = "sleep 60; ssh-keyscan ${self.public_ip} >> ~/.ssh/known_hosts"
  }

  provisioner "local-exec" {
    command = "echo ${var.microservice_name} id=${self.id} ansible_host=${self.public_ip} ansible_user=ubuntu aws_region=${var.region} aws_s3_bucket=${length(aws_s3_bucket.microservice_s3) > 0 ? aws_s3_bucket.microservice_s3[0].bucket : "N/A"} aws_dynamodb_table=${length(aws_dynamodb_table.microservice_dynamodb) > 0 ? aws_dynamodb_table.microservice_dynamodb[0].name : "N/A"} >> /etc/ansible/hosts"

  }

  provisioner "local-exec" {
    command = "sed -i '/${self.id}/d' /etc/ansible/hosts"
    when    = destroy
  }


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

resource "aws_iam_role" "s3_dynamodb_full_access_role" {
  name = "sgp-${var.microservice_name}-s3_dynamodb_full_access_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    Name = "sgp-${var.microservice_name}"
  }

}

resource "aws_iam_role_policy_attachment" "s3_full_access_role_policy_attachment" {
  role       = aws_iam_role.s3_dynamodb_full_access_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"

}

resource "aws_iam_role_policy_attachment" "dynamodb_full_access_role_policy_attachment" {
  role       = aws_iam_role.s3_dynamodb_full_access_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"

}

resource "aws_iam_instance_profile" "s3_dynamodb_full_access_instance_profile" {
  name = "sgp-${var.microservice_name}-s3_dynamodb_full_access_instance_profile"
  role = aws_iam_role.s3_dynamodb_full_access_role.name

  tags = {
    Name = "sgp-${var.microservice_name}"
  }
}

