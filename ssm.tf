resource "aws_iam_policy" "session_manager_policy" {
    name = "SSM-Session-Manager-Policy"
    description = "Policy to allow access to EC2 using Sesssion Manager"
    policy      = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "ssm:StartSession",
          "ssm:DescribeSessions",
          "ssm:TerminateSession"
        ],
        "Resource": [
          "arn:aws:ssm:*:*:document/AWS-StartSSHSession",
          "arn:aws:ssm:*:*:document/AWS-StartPortForwardingSession"
        ]
      }
    ]
  })
}

# Attach to Users
resource "aws_iam_user_policy_attachment" "user_a_ssm_policy" {
  user       = aws_iam_user.A.name
  policy_arn = aws_iam_policy.session_manager_policy.arn
}

resource "aws_iam_user_policy_attachment" "user_b_ssm_policy" {
  user       = aws_iam_user.B.name
  policy_arn = aws_iam_policy.session_manager_policy.arn
}

resource "aws_iam_user_policy_attachment" "user_c_ssm_policy" {
  user       = aws_iam_user.C.name
  policy_arn = aws_iam_policy.session_manager_policy.arn
}

resource "aws_iam_user_policy_attachment" "user_d_ssm_policy" {
  user       = aws_iam_user.D.name
  policy_arn = aws_iam_policy.session_manager_policy.arn
}