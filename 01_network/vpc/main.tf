# AWSプロバイダーの設定
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket = "aws-intro-sample-hide"        # S3バケット名を更新
    key    = "network/terraform.tfstate"    # S3内でのtfstateファイルのパス
    region = "ap-southeast-2"               # S3バケットのリージョン
  }
}

# AWSリージョンの指定
provider "aws" {
  region = var.region
}

locals {
  common_tags = merge(
    var.tags,
    {
      Environment = var.environment
      Project     = var.project
    }
  )
}

# VPCの作成
resource "aws_vpc" "main" {
  # VPCのIPv4 CIDRブロックを指定
  cidr_block           = var.vpc_cidr
  # VPC内のインスタンスにパブリックDNSホスト名を自動的に割り当てる
  enable_dns_hostnames = true
  # VPC内でDNS解決を有効にする
  enable_dns_support   = true

  tags = merge(
    local.common_tags,
    {
      Name = var.vpc_name
    }
  )
}

# VPCのIDを出力
output "vpc_id" {
  value = aws_vpc.main.id
}

# パブリックサブネットの作成
resource "aws_subnet" "public" {
  count             = length(var.public_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = var.azs[count.index]

  map_public_ip_on_launch = true

  tags = merge(
    local.common_tags,
    {
      Name = "${var.vpc_name}-public-${count.index + 1}"
      Tier = "Public"
    }
  )
}

# プライベートサブネットの作成
resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = merge(
    local.common_tags,
    {
      Name = "${var.vpc_name}-private-${count.index + 1}"
      Tier = "Private"
    }
  )
}

# インターネットゲートウェイの作成
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.vpc_name}-igw"
    }
  )
}

# パブリックルートテーブルの作成
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${var.vpc_name}-public-rt"
      Tier = "Public"
    }
  )
}

# パブリックサブネットとルートテーブルの関連付け
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# プライベートルートテーブルの作成
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.vpc_name}-private-rt"
      Tier = "Private"
    }
  )
}

# プライベートサブネットとルートテーブルの関連付け
resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}