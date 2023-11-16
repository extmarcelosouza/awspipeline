resource "aws_codecommit_repository" "api-cnh" {
  repository_name = "api-cnh"
  description     = "api-cnh repository"

  tags = {
    name = "api-cnh"
  }
  default_branch = "main"
  }
