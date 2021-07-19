provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

locals {
    local_account_id_root     = "arn:aws:iam::${var.aws_account_id}:root"
    readonly_account_arn_list = "${var.readonly_account_arns}" != [""] ? "${var.readonly_account_arns}" : ["${local.local_account_id_root}"]
}
