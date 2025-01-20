terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket         = "aws-intro-sample-hide"
    key            = "network/stg/terraform.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "terraform-state-lock"
  }
}

provider "aws" {
  region = "ap-southeast-2"
}

module "vpc" {
  source = "../vpc"

  # VPC設定
  vpc_cidr = "10.1.0.0/16"  # ステージング環境用のCIDR
  vpc_name = "stg-vpc"

  # サブネット設定
  public_subnet_cidrs = {
    "ap-southeast-2a" = "10.1.0.0/20"
    "ap-southeast-2c" = "10.1.16.0/20"
  }
  
  private_subnet_cidrs = {
    "ap-southeast-2a" = "10.1.64.0/20"
    "ap-southeast-2c" = "10.1.80.0/20"
  }

  # 環境タグ
  environment = "stg"
} 