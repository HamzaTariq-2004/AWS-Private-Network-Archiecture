resource "aws_internet_gateway" "igw-A" {
    vpc_id = aws_vpc.VPC-A.id

    tags = {
      Name = "IGW-A"
    }
}

resource "aws_internet_gateway" "igw-B" {
    vpc_id = aws_vpc.VPC-B.id

    tags = {
      Name = "IGW-B"
    }
}

resource "aws_route_table" "rt-A" {
    vpc_id = aws_vpc.VPC-A.id

    tags = {
      Name = "RT-A"
    }
}

resource "aws_route" "route-A" {
    route_table_id = aws_route_table.rt-A.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-A.id
}

resource "aws_route_table_association" "attach-rt-A" {
    subnet_id = aws_subnet.public-subnet-A.id
    route_table_id = aws_route_table.rt-A.id
}

resource "aws_route_table" "rt-B" {
    vpc_id = aws_vpc.VPC-B.id

    tags = {
      Name = "RT-B"
    }
}

resource "aws_route" "route-B" {
    route_table_id = aws_route_table.rt-B.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-B.id
}

resource "aws_route_table_association" "attach-rt-B" {
    subnet_id = aws_subnet.public-subnet-B.id
    route_table_id = aws_route_table.rt-B.id
}