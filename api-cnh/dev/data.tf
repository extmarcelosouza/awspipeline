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

# data "aws_iam_policy_document" "policy_ecr" {
#   statement {

#     effect = "Allow"

#     actions = [
#       "ecr:CompleteLayerUpload",
#       "ecr:GetAuthorizationToken",
#       "ecr:UploadLayerPart",
#       "ecr:InitiateLayerUpload",
#       "ecr:BatchCheckLayerAvailability",
#       "ecr:PutImage",
#     ]

#     resources = ["*"]
#   }
# }

# data "aws_iam_policy_document" "codebuildbase_policy" {
#   statement {

#     effect = "Allow"

#     actions = [
#       "logs:CreateLogGroup",
#       "logs:CreateLogStream",
#       "logs:PutLogEvents",
#     ]

#     resources = ["*"]
#   }

#   statement {

#     effect = "Allow"

#     actions = [
#       "s3:PutObject",
#       "s3:GetObject",
#       "s3:GetObjectVersion",
#       "s3:GetBucketAcl",
#       "s3:GetBucketLocation",
#     ]

#     resources = ["arn:aws:s3:::codepipeline-us-east-1-*"]
#   }

#   statement {

#     effect = "Allow"

#     actions = [
#       "codecommit:GitPull"
#     ]

#     resources = ["arn:aws:codecommit:us-east-1:058758721812:api-fi"]
#   }

#   statement {

#     effect = "Allow"

#     actions = [
#       "codebuild:CreateReportGroup",
#       "codebuild:CreateReport",
#       "codebuild:UpdateReport",
#       "codebuild:BatchPutTestCases",
#       "codebuild:BatchPutCodeCoverages",
#     ]

#     resources = ["arn:aws:codebuild:us-east-1:058758721812:report-group/api-cnh-fi-*"]
#   }


# }
# data "aws_iam_policy_document" "policy_vpc" {
#   statement {
#     effect = "Allow"

#     actions = [
#       "ec2:CreateNetworkInterface",
#       "ec2:DescribeDhcpOptions",
#       "ec2:DescribeNetworkInterfaces",
#       "ec2:DeleteNetworkInterface",
#       "ec2:DescribeSubnets",
#       "ec2:DescribeSecurityGroups",
#       "ec2:DescribeVpcs",
#     ]

#     resources = ["*"]
#   }

#   statement {
#     effect    = "Allow"
#     actions   = ["ec2:CreateNetworkInterfacePermission"]
#     resources = ["arn:aws:ec2:us-east-1:058758721812:network-interface/*"]

#     condition {
#       test     = "StringEquals"
#       variable = "ec2:Subnet"

#       values = [
#         "arn:aws:ec2:us-east-1:058758721812:subnet/subnet-06c442f900f83fdf4",
#         "arn:aws:ec2:us-east-1:058758721812:subnet/subnet-0578f0c840b092b7b"
#       ]
#     }

#     condition {
#       test     = "StringEquals"
#       variable = "ec2:AuthorizedService"
#       values   = ["codebuild.amazonaws.com"]
#     }
#   }
# }
