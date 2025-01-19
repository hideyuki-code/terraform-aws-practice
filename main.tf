# AWSプロバイダーの設定
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# AWSリージョンの指定
provider "aws" {
  region = "ap-southeast-2"  # シドニーリージョン
}

# VPCの作成
resource "aws_vpc" "main" {
  # VPCのIPv4 CIDRブロックを指定
  cidr_block           = "10.0.0.0/16"
  # VPC内のインスタンスにパブリックDNSホスト名を自動的に割り当てる
  enable_dns_hostnames = true
  # VPC内でDNS解決を有効にする
  enable_dns_support   = true

  # タグの設定
  tags = {
    Name = "sample-vpc"  # VPCの識別名
  }
}