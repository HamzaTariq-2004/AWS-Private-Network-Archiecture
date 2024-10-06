resource "aws_instance" "Server-B" {
    subnet_id = aws_subnet.subnet-B.id
    security_groups = [aws_security_group.vpcB-SG.id]
    ami = "ami-0866a3c8686eaeeba"
    instance_type = "t2.micro"
    key_name = "ServerKey"
    associate_public_ip_address = false
   
    metadata_options {
      http_tokens = "required" #enfore IMDSv2
    }

     ebs_block_device {
      device_name = "/dev/sda1"
      delete_on_termination = true
      encrypted = true
    }

    # user_data = <<-EOF
    #           #!/bin/bash
    #           apt update -y
    #           apt install -y wget
    #           wget https://dl.grafana.com/oss/release/grafana-7.5.7-1.x86_64.deb
    #           apt install -y ./grafana-7.5.7-1.x86_64.deb
    #           systemctl start grafana-server
    #           systemctl enable grafana-server
    #           EOF

    #Attach IAM Role EC2 instance
    iam_instance_profile = aws_iam_instance_profile.ec2_role_profile.name

    tags = {
      Name = "Server-B"
    }
}