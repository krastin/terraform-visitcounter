variable "aws_profile" {
  default = ""
}
variable "aws_region" {
  default = "eu-west-1"
}

provider "aws" {
  profile    = "${var.aws_profile}"
  region     = "${var.aws_region}"
}
