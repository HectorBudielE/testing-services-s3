##############################
## AWS Provider Defaults
##----------------------------
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {
    default = "us-east-1"
}

##############################
## AWS Tags
##----------------------------
variable "project" {}
variable "environment" {}
variable "owner" {}
variable "service" {}
variable "product" {}
variable "portfolio" {}


##############################
## AWS Account Information
##----------------------------
variable "aws_account_id" {}

###################################
## AWS Account with Readonly Access
##---------------------------------
variable "readonly_account_arns"{
    type    = list
    default = [""]
}

##############################
## AWS Expiration Policy
##----------------------------

variable "los_lifecycle_deletion_enabled" {
    default = false
}

variable "los_lifecycle_deletion_time_days" {
    default = 547
}
