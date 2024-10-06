resource "aws_vpc" "VPC-B" {
    cidr_block = "10.1.0.0/16"

    tags = {
      Name = "VPC-B"
    }
}