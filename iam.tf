# Create a single IAM role for EC2 to access both S3 and SSM
resource "aws_iam_role" "ec2_ssm_s3_access_role" {
  name = "ec2_ssm_s3_access_role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# Create a policy with both S3 and SSM access
resource "aws_iam_role_policy" "ec2_ssm_s3_access_policy" {
  name = "ec2_ssm_s3_access_policy"
  role = aws_iam_role.ec2_ssm_s3_access_role.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # SSM Access Policy
      {
        Action = "ssm:*"
        Effect = "Allow"
        Resource = "*"
      },
      # S3 Bucket Access Policy
      {
        Action = ["s3:GetObject", "s3:ListBucket"]
        Effect = "Allow"
        Resource = [
          "${aws_s3_bucket.my-bucket.arn}",       # Refers to the bucket itself
          "${aws_s3_bucket.my-bucket.arn}/*"      # Refers to all objects inside the bucket
        ]
      }
    ]
  })
}

# Create IAM Instance Profile for the combined role
resource "aws_iam_instance_profile" "ec2_ssm_s3_profile" {
  name = "ec2_ssm_s3_access_profile"
  role = aws_iam_role.ec2_ssm_s3_access_role.name
}

#Create an IAM role for EC2 with SSM Access
resource "aws_iam_role" "ec2_ssm_role" {
    name = "EC2-SSM-Role"
    assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
       }
     ]
  })
}

# Attach the AmazonSSMManagedInstanceCore policy to the role
resource "aws_iam_policy_attachment" "ssm_policy_attachment" {
  name       = "SSM_Policy_Attachment"
  roles      = [aws_iam_role.ec2_ssm_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Create IAM Instance Profile
resource "aws_iam_instance_profile" "ec2_role_profile" {
  name = "EC2_Role_Profile"
  role = aws_iam_role.ec2_ssm_role.name
}