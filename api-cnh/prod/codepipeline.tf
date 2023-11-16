resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "codepipeline-us-east-1-441828617990"
}

resource "aws_codepipeline" "codepipeline" {
  name     = "api-cnh-prod"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name     = "api-cnh-prod"
      category = "Source"
      owner    = "AWS"
      provider = "CodeCommit"
      version  = "1"
      output_artifacts = ["source_output"]

      configuration = {
        RepositoryName = "api-cnh"
        BranchName       = "master"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name     = "api-cnh-prod"
      category = "Build"
      owner    = "AWS"
      provider = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version = "1"

      configuration = {
        ProjectName = "api-cnh-prod"
      }
    }
  }
}
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "codepipeline_role" {
  name               = "pipeline-cnh-prod-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name   = "codepipeline_policy"
  role   = aws_iam_role.codepipeline_role.id
  policy = "${file("servicerole_policy.json")}"
}
