output "aws_console_url" {
  value = [
    "https://console.aws.amazon.com",
  ]
}

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

output "Access_key_id" {
  value = ["${aws_iam_access_key.tl_user.id}"]
}
output "Access_key_secret" {
  value = ["${aws_iam_access_key.tl_user.secret}"]
}
