# Configure the AWS Provider
provider "aws" {
    region = "eu-west-3"
    access_key = var.AWS_KEY
    secret_key = var.AWS_SECRET
}

resource "aws_instance" "myec2"{
    ami = "ami-0ddab716196087271"
    instance_type = "t2.micro"
}