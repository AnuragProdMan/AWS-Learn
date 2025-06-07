provider "aws" {
  region = var.aws_region
}

# Use default VPC
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}


# Security Group to allow HTTP
resource "aws_security_group" "app_sg" {
  name        = "springboot-sg"
  description = "Allow HTTP access"
  vpc_id      = data.aws_vpc.default.id

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
}

# IAM role for EC2 instance to pull ECR image
resource "aws_iam_role" "ec2_role" {
  name = "springboot-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecr_read" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "springboot-profile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_instance" "springboot_instance" {
  ami                    = "ami-0a0f1259dd1c90938" # Amazon Linux 2 in ap-south-1
  instance_type          = "t2.micro"
  subnet_id              = data.aws_subnets.default.ids[0]
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  associate_public_ip_address = true



  tags = {
    Name = "springboot-instance"
  }
}
