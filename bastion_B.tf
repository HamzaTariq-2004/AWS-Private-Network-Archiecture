resource "aws_instance" "bastion-B" {
    subnet_id = aws_subnet.public-subnet-B.id
    security_groups = [aws_security_group.bastion-sg-B.id]
    ami = "ami-0866a3c8686eaeeba"
    instance_type = "t2.micro"
    key_name = "ServerKey"
    associate_public_ip_address = true

    metadata_options {
      http_tokens = "required" #enfore IMDSv2
    }

     ebs_block_device {
      device_name = "/dev/sda1"
      delete_on_termination = true
      encrypted = true
    }

    tags = {
      Name = "Bastion-B"
    }
}