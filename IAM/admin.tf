provider "aws" {
  region     = "us-west-2"
  access_key = "AKIAIA7H3ISGMBV4I7XA"
  secret_key = "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"
}

variable "user_name" {}

resource "aws_iam_user" "admin" {
  name = "${var.user_name}"
}

resource "aws_iam_user_policy" "lb_ro" {
  name = "test"
  user = "${aws_iam_user.admin.name}"

  policy = "${file("admin.json")}"
}

resource "aws_iam_user_login_profile" "u" {
  user                    = "${aws_iam_user.admin.name}"
  password_reset_required = true
  pgp_key                 = "keybase:deekshithsn"
}

output "username" {
  value = "${aws_iam_user.admin.name}"
}

output "password" {
  value = "${aws_iam_user_login_profile.u.encrypted_password}"
}