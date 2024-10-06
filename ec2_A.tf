resource "aws_instance" "Server-A" {
    subnet_id = aws_subnet.subnet-A.id
    security_groups = [aws_security_group.vpcA-SG.id]
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
    #           apt install -y openjdk-11-jdk wget
    #           wget https://archive.apache.org/dist/nifi/1.15.3/nifi-1.15.3-bin.tar.gz
    #           tar -xvzf nifi-1.15.3-bin.tar.gz
    #           mv nifi-1.15.3 /opt/nifi
    #           /opt/nifi/bin/nifi.sh start
    #           EOF

    #Attach IAM Role EC2 instance
    iam_instance_profile = aws_iam_instance_profile.ec2_ssm_s3_profile.name

    tags = {
      Name = "Server-A"
    }
}   