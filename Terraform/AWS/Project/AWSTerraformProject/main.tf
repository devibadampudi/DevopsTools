data "aws_caller_identity" "current" {}

resource "random_id" "unique_string" {
  keepers = {
    #Generate a new id each time we create a VCN environment
  }

  byte_length = 2
}

resource "random_id" "password" {
  keepers = {
    #Generate a new id each time we create a VCN environment
  }

  byte_length = 2
}

resource "aws_iam_group" "tl_users_group" {
  name = "${var.group_name}${random_id.unique_string.hex}"
}

resource "aws_iam_policy" "tl_policy" {
  name        = "${var.policy_name}${random_id.unique_string.hex}"
  description = "Policy for creating VPC, Subnet, RT, IGW, SG, EC2 Key Pair and EC2 Instances"

  policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [{
      "Effect": "Allow",
      "Action": [
                "ec2:*"
            ],
      "Resource": "*",
      "Condition": {
         "StringEquals": {
            "aws:RequestedRegion": "${var.region}"
                }
            }
        }
    ]
}
EOF
}

resource "aws_iam_group_policy_attachment" "policy-attach" {
  group      = "${aws_iam_group.tl_users_group.name}"
  policy_arn = "${aws_iam_policy.tl_policy.arn}"
}

resource "aws_iam_user" "tl_user" {
  name          = "${var.username}${random_id.unique_string.hex}"
  path          = "/system/"
  force_destroy = "true"
}

resource "aws_iam_access_key" "tl_user" {
  user    = "${aws_iam_user.tl_user.name}"

}
resource "null_resource" "password" {
  provisioner "local-exec" {
    command = "aws configure set aws_access_key_id ${var.access_key} && aws configure set aws_secret_access_key ${var.secret_key} && aws configure set default.region ${var.region} && aws iam create-login-profile --user-name ${var.username}${random_id.unique_string.hex} --password ${var.username}@${random_id.password.hex}"
  }
}

resource "aws_iam_group_membership" "add_user_to_group" {
  depends_on = [
    "aws_iam_user.tl_user",
  ]

  name = "${var.group_membership_name}${random_id.unique_string.hex}"

  users = [
    "${var.username}${random_id.unique_string.hex}",
  ]

  group = "${var.group_name}${random_id.unique_string.hex}"
}


