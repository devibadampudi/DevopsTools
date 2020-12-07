output "account_id" {
  value = [
    "${data.aws_caller_identity.current.account_id}",
  ]
}

output "aws_username" {
  value = [
    "${aws_iam_user.tl_user.name}",
  ]
}

output "aws_password" {
  value = [
    "${var.username}@${random_id.password.hex}",
  ]
}

output "region" {
  value = [
    "${var.location[var.region]}",
  ]
}


output "secret" {
  value = ["${aws_iam_access_key.access_key.secret}",]
}


output "id" {
  value = ["${aws_iam_access_key.access_key.id}",]
}

output "config_map_aws_auth" {
  value = ["${local.config_map_aws_auth}",]
}

#  output "kubeconfig" {
#   value = [
#     "${local.kubeconfig}",
#   ]
# }

