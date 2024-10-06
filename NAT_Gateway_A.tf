resource "aws_eip" "eip-A" {
    tags = {
      Name = "EIP-A"
    }
}

resource "aws_nat_gateway" "nat-gw-A" { 
    subnet_id = aws_subnet.public-subnet-A.id
    allocation_id = aws_eip.eip-A.id
}

