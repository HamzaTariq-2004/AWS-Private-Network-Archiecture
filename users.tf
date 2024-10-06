resource "aws_iam_user" "A" {
    name = "A"
}

resource "aws_iam_user" "B" {
    name = "B"
}

resource "aws_iam_user" "C" {
    name = "C"
}

resource "aws_iam_user" "D" {
    name = "D"
}

resource "aws_iam_user" "E" {
    name = "E"
}

resource "aws_iam_user_policy_attachment" "admin_policy" {
    user = aws_iam_user.A.name
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_policy" "policy_b" {
    name = "B-NiFi-Grafana-policy"
    description = "Policy for User B to access NiFi and Grafana"
    policy      = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": ["s3:ListBucket"],
        "Resource": ["${aws_s3_bucket.my-bucket.arn}"]
      },
      {
        "Effect": "Deny",
        "Action": ["s3:GetObject"],
        "Resource": ["${aws_s3_bucket.my-bucket.arn}/*"]
      },
      {
        "Effect": "Allow",
        "Action": [
          "nifi:access",
          "grafana:access"
        ],
        "Resource": "*"
      }
    ]
  })
}

resource "aws_iam_policy" "policy_c" {
    name        = "Grafana-Only-Policy"
    description = "Policy for Users C and D to access Grafana only"
    policy      = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "grafana:access"
        ],
        "Resource": "*"
      }
    ]
  })
}

#Attach policies to users
resource "aws_iam_user_policy_attachment" "user_b_policy" {
    user = aws_iam_user.B.name
    policy_arn = aws_iam_policy.policy_b.arn
}

resource "aws_iam_user_policy_attachment" "user_c_policy" {
    user = aws_iam_user.C.name
    policy_arn = aws_iam_policy.policy_c.arn
}

#As C and D have same policies
resource "aws_iam_user_policy_attachment" "user_d_policy" {
    user = aws_iam_user.D.name
    policy_arn = aws_iam_policy.policy_c.arn
}