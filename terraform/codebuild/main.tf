provider "aws" {
  region = "ap-northeast-2"
}
terraform {
  backend "s3" {
    region         = "ap-northeast-2"
    bucket         = "ch-greeting-service-bucket"
    key            = "ch-greeting-service/terraform.state"
    encrypt        = true
    dynamodb_table = "terraform_lock"
  }
}

data "aws_vpc" "default" {
  id = "vpc-85f648ee"
}

data "aws_iam_role" "codebuild-default-role" {
  name = "codebuild-default-role"
}

data "aws_security_group" "codebuild-security-group" {
  name = "codebuild-security-group"
}

resource "aws_codebuild_project" "googleplay-dumper-codebuild" {
  name          = "greeting-service-codebuild"
  build_timeout = 15
  service_role  = data.aws_iam_role.codebuild-default-role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_MEDIUM"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/ChanghwanK/greeting-service.git"
    git_clone_depth = 5
    buildspec       = "codebuild/deploy.yml"

  }

  source_version = "master"

  vpc_config {
    vpc_id             = "vpc-85f648ee"
    security_group_ids = ["sg-0fac80a15d5e9d2c4"]
    subnets            = ["subnet-09dcea457a9dda5c1"]
  }
}