resource "aws_iam_role" "tenableio-connector" {
    name = "tenableio-connector"

    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::AWSaccountid:root"
            },
            "Action": "sts:AssumeRole",
            "Condition": {
                "StringEquals": {
                    "sts:ExternalId": "------------------------"
                }
            }
        }
    ]
}
EOF
}

resource "aws_iam_policy" "testPolicy1" {
    name        = "ec2-policy1"
    description = "A test policy1"

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "ec2:DescribeInstances",
            "Resource": "*"
        }
    ]
}

EOF
}

resource "aws_iam_role_policy_attachment" "test-attach1" {
    role       = aws_iam_role.tenableio-connector.name
    policy_arn = aws_iam_policy.testPolicy1.arn
}

resource "aws_iam_policy" "testPolicy2" {
    name        = "org-policy2"
    description = "A test policy2"

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "organizations:ListAccounts",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "test-attach2" {
    role       = aws_iam_role.tenableio-connector.name
    policy_arn = aws_iam_policy.testPolicy2.arn
}

resource "aws_iam_policy" "testPolicy3" {
    name        = "trail-policy3"
    description = "A test policy"

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "cloudtrail:LookupEvents",
                "cloudtrail:ListTags",
                "cloudtrail:GetTrailStatus",
                "cloudtrail:GetEventSelectors",
                "cloudtrail:DescribeTrails"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "test-attach3" {
    role       = aws_iam_role.tenableio-connector.name
    policy_arn = aws_iam_policy.testPolicy3.arn
}
