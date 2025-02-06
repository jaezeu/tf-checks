provider "aws" {
  region = "ap-southeast-1"
}

terraform {
  backend "s3" {
    bucket = "sctp-ce8-tfstate"
    key    = "jaz-s3-tf-ci.tfstate"  #Change this
    region = "ap-southeast-1"
  }
}

data "aws_caller_identity" "current" {}

locals {
  name_prefix = "${split("/", "${data.aws_caller_identity.current.arn}")[1]}"
  account_id  = "${data.aws_caller_identity.current.account_id}"
}

resource "aws_s3_bucket" "s3_tf" {
  bucket = "${local.name_prefix}-s3-tf-bkt-${local.account_id}"
}