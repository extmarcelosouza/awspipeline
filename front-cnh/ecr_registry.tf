resource "aws_ecr_repository" "front-cnh-dev" {
  name                 = "front-cnh-dev"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
  tags = {
    env = "dev"
    name = "front-cnh"
  }
}

resource "aws_ecr_repository" "front-cnh-stage" {
  name                 = "front-cnh-stage"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
  tags = {
    env = "stage"
    name = "front-cnh"
  }
}

resource "aws_ecr_repository" "front-cnh-sandbox" {
  name                 = "front-cnh-sandbox"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
  tags = {
    env = "sandbox"
    name = "front-cnh"
  }
}

resource "aws_ecr_repository" "front-cnh-prod" {
  name                 = "front-cnh-prod"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
  tags = {
    env = "prod"
    name = "front-cnh"
  }
}

## POLICIES DO ECR

resource "aws_ecr_repository_policy" "ecr-policy-front-cnh-sandbox" {
  repository = aws_ecr_repository.front-cnh-sandbox.name

  policy = jsonencode({
    Version = "2008-10-17",
    Statement = [
      {
        Sid = "AllowPull",
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::503662173770:root"  
        },
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetAuthorizationToken"  
        ]
      }
    ]
  })
}

resource "aws_ecr_repository_policy" "ecr-policy-front-cnh-stage" {
  repository = aws_ecr_repository.front-cnh-stage.name

  policy = jsonencode({
    Version = "2008-10-17",
    Statement = [
      {
        Sid = "AllowPull",
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::251694106756:root"  
        },
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetAuthorizationToken"  
        ]
      }
    ]
  })
}

resource "aws_ecr_repository_policy" "ecr-policy-front-cnh-prod" {
  repository = aws_ecr_repository.front-cnh-prod.name

  policy = jsonencode({
    Version = "2008-10-17",
    Statement = [
      {
        Sid = "AllowPull",
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::113412148517:root"  
        },
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetAuthorizationToken"  
        ]
      }
    ]
  })
}
