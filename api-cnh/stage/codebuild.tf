
resource "aws_codebuild_project" "api-cnh-stage" {
  name         = "api-cnh-stage"
  service_role = aws_iam_role.servicerole-stage.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = "058758721812"
    }

    environment_variable {
      name  = "IMAGE_REPO_NAME"
      value = "api-cnh-stage"
      type  = "PLAINTEXT"
    }

    environment_variable {
      name  = "IMAGE_TAG"
      value = "latest"
      type  = "PLAINTEXT"
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name = "api-cnh-stage"
    }
  }

  source {
    type            = "CODECOMMIT"
    location        = "https://git-codecommit.us-east-1.amazonaws.com/v1/repos/api-cnh"
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = false
    }
  }

  source_version = "stage"

  vpc_config {
    vpc_id = data.aws_vpc.vpc.id

    subnets = [
      data.aws_subnet.subnet1.id,
      data.aws_subnet.subnet2.id,
    ]

    security_group_ids = [
      data.aws_security_group.sg.id,
    ]
  }

  tags = {
    Environment = "stage"
  }
}

resource "aws_iam_role" "servicerole-stage" {
  name               = "servicerole-api-cnh-stage"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "ecr_policy" {
  name   = "ecr_policy"
  role   = aws_iam_role.servicerole-stage.name
  policy = file("ecr_policy.json")
}

resource "aws_iam_role_policy" "codebuildbase_policy" {
  name   = "codebuildbase_policy"
  role   = aws_iam_role.servicerole-stage.name
  policy = file("codebuildbase_policy.json")
}

resource "aws_iam_role_policy" "vpc_policy" {
  name   = "vpc_policy"
  role   = aws_iam_role.servicerole-stage.name
  policy = file("vpc_policy.json")
}

resource "aws_iam_role_policy" "secrets_policy" {
  name   = "secretsmanager_policy"
  role   = aws_iam_role.servicerole-stage.name
  policy = file("secrets_policy.json")
}