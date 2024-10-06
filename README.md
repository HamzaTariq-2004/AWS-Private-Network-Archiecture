AWS Private Network Architecture
 
Description
Private network running Apache NiFi in one VPC on EC2 instance that is fetching data from S3 bucket using gateway endpoint, processes it and send to another peered VPC in the same region hosting Grafana for the visulization of processed data to end users.

Services Used
1.VPC (Peering, Subnets, NAT Gateways, Gateway endpoint, Internet gateways)
2.EC2
3.S3
4.Session Manager
5.IAM (users, roles)

Architecture Setup
In us-east-1, two VPCs (A & B) are created that are peered so that they can communicate. 

VPC-A
In this VPC there are two subnets, public and private. Public subnet contains one NAT Gateway that is further connected to EC2 instance of the same VPC’s private subnet and one Ubuntu based bastion host for SSH. In Private subnet, one EC2 is containing the Apche NiFi that is taking data in CSV from S3 bucket that is connected to this VPC via gateway endpoint. Processes this data and send to VPC-B

VPC-B
Similarly running two subnets, public subnet is same as that of VPC-A but the private subnet is hosting Grafana application that is taking data from Apache NiFi for visualization.
 
