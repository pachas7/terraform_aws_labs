provider "aws" {
    region = "eu-west-3"
    access_key = var.AWS_KEY
    secret_key = var.AWS_SECRET
}

resource "aws_instance" "myec2" {
   ami = "ami-02b01316e6e3496d9"
   instance_type = "t2.micro"
}

resource "aws_eip" "lb" {
  vpc      = true
}

resource "aws_s3_bucket" "mys3" {
  bucket = "kplabs-attribute-demo-001-pach"
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.myec2.id
  allocation_id = aws_eip.lb.id
}

resource "aws_security_group" "allow_tls" {
  name        = "kplabs-security-group"
  vpc_id      = "vpc-07f0f9192006b647c"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${aws_eip.lb.public_ip}/32"]
  }
}

output "eip" {
  value = aws_eip.lb
}

output "mys3bucket" {
  value = aws_s3_bucket.mys3
}
