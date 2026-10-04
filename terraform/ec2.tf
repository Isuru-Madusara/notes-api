data "aws_vpc" "default" {
  default = true
}

data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_security_group" "web" {
  name        = "notes-api-web-sg"
  description = "Allow HTTP in and all traffic out"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app" {
  ami                         = data.aws_ami.al2023.id
  instance_type               = var.instance_type
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  vpc_security_group_ids      = [aws_security_group.web.id]
  associate_public_ip_address = true
  user_data                   = file("${path.module}/user_data.sh")
  user_data_replace_on_change = true

  metadata_options {
    http_tokens = "required"
  }

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  tags = {
    Name      = "notes-api-server"
    Project   = "notes-api"
    ManagedBy = "terraform"
  }
}
