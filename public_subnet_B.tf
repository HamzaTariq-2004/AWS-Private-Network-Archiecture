resource "aws_subnet" "public-subnet-B" {
    vpc_id = aws_vpc.VPC-B.id
    cidr_block = "10.1.1.0/24"
    availability_zone = "us-east-1b"

    tags = {
      Name = "Public-Subnet-B"
    }
}