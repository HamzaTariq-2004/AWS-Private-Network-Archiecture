resource "aws_subnet" "subnet-B" {
    vpc_id = aws_vpc.VPC-B.id
    cidr_block = "10.1.0.0/24"
    availability_zone = "us-east-1b"

    tags = {
      Name = "Subnet-B"
    }
}