provider "aws" {
  region = "us-west-2"
}

# Finds the AZ that is available during creating of the resources
data "aws_availability_zones" "available" {}

locals {
  zone = "${data.aws_availability_zones.available.names[0]}"

  # AWS x86 
  ami           = "ami-07a0c6e669965bb7c"
  instance_type = "t2.micro"
  key_name      = "mykeypair"

  vpc_cidr    = "10.0.0.0/16"
  subnet_cidr = "10.0.0.0/24"
  private_ip  = "10.0.0.12"

  tags {
    Name = "HelloWorld"
  }
}
