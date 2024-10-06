resource "aws_s3_bucket" "my-bucket" {
    bucket = "bucket-of-hamza-1"

    tags = {
      Name = "bucket-of-hamza-1"
    }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
    bucket = aws_s3_bucket.my-bucket.id

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Principal = "*"
                Action = "s3:GetObject"
                Resource = "${aws_s3_bucket.my-bucket.arn}/*"
                Condition = {
                    StringEquals = {
                        #Restrict access to the traffic coming from the VPC Gateway endpoint only
                        "aws:SourceVpce" = "${aws_vpc_endpoint.s3-endpoint.id}"
                    }
                }
            }
        ]
    })

}