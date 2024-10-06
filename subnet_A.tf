resource "aws_subnet" "subnet-A" {
    vpc_id = aws_vpc.VPC-A.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"

    tags = {
      Name = "Subnet-A"
    }
}