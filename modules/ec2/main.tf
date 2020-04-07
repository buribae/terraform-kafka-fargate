# -------------------------
# EC2
# -------------------------

data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


resource "aws_instance" "create_topic" {
  ami                         = data.aws_ami.amazon-linux-2.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  key_name                    = "StephenJang"
  vpc_security_group_ids      = [aws_security_group.sg-ec2.id]
  subnet_id                   = var.subnet_ids[0]
}

# -------------------------
# EC2 - Security Group
# -------------------------
resource "aws_security_group" "sg-ec2" {
  name        = "${var.prefix}-ec2-sg"
  description = "Allow TLS"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "TCP"

    cidr_blocks = var.ingress_cidr
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}
