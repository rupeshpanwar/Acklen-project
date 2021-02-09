#create IAM role to allow accessing AWS service
resource "aws_iam_role" "ec2-iam-role" {
  name = "EC2-IAM-Role"
  assume_role_policy = <<EOF
{
  "Version" : "2012-10-17",
  "Statement" :
  [
    {
      "Effect" : "Allow",
      "Principal" : {
        "Service" : ["ec2.amazonaws.com", "application-autoscaling.amazonaws.com"]
      },
      "Action" : "sts:AssumeRole"
    }
  ]
}
EOF
}
#attach IAM policy
resource "aws_iam_role_policy" "ec2-iam-role-policy" {
  name = "EC2-IAM-Policy"
  role =  aws_iam_role.ec2-iam-role.id
  policy  = <<EOF
{
  "Version" : "2012-10-17",
  "Statement" : [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:*",
        "elasticloadbalancing:*",
        "cloudwatch:*",
        "logs:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}
#create IAM Instance profile
resource "aws_iam_instance_profile" "ec2-instance-profile" {
  name = "EC2-IAM-Instance-Profile"
  role = aws_iam_role.ec2-iam-role.name
}