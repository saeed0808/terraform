resource "aws_iam_role" "tenableio-connector" {
  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::-------------:root"
            },
            "Action": "sts:AssumeRole",
            "Condition": {
                "StringEquals": {
                    "sts:ExternalId": "-----------------------"
                }
            }
        }
    ]
}
POLICY

  description          = "Allows ec2 tenableio"
  managed_policy_arns  = ["arn:aws:iam::aws:policy/AmazonEC2FullAccess", "arn:aws:iam::aws:policy/AWSOrganizationsFullAccess", "arn:aws:iam::aws:policy/AWSCloudTrail_FullAccess"]
  max_session_duration = "3600"
  name                 = "tenableio-connector"
  path                 = "/"
}
