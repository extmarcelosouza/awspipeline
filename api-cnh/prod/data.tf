data "aws_vpc" "vpc" {
  id = "vpc-0a1ac9cdb8ab56b44"
}

data "aws_subnet" "subnet1" {
  id = "subnet-06c442f900f83fdf4"
}

data "aws_subnet" "subnet2" {
  id = "subnet-0578f0c840b092b7b"
}

data "aws_security_group" "sg" {
  id = "sg-0ed4f50ca1942fa4d"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}


