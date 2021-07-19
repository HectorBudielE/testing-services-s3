provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

locals {
    local_account_id_root     = "arn:aws:iam::${var.aws_account_id}:root"
    readonly_account_arn_list = "${split(" ", length(var.readonly_account_arns) == 0 ? local.local_account_id_root : join(" ",var.readonly_account_arns))}"
}
