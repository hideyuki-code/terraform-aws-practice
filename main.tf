cat << EOF > main.tf
# Terraformの基本設定
# required_providersブロックで使用するプロバイダーを定義
terraform {
  required_providers {
    # AWSプロバイダーの設定
    aws = {
      source  = "hashicorp/aws"  # HashiCorpが提供する公式AWSプロバイダー
      version = "~> 4.0"         # バージョン4.x系を使用（~>は、4.0以上5.0未満を意味）
    }
  }
}

# AWSプロバイダーの設定
# この設定によって、AWSの各サービスにアクセスできるようになります
provider "aws" {
  region = "ap-northeast-1"  # AWSリージョンを東京（ap-northeast-1）に設定
}

# ===================================
# ここに後でリソースを追加していきます
# リソースの例：
# - VPC
# - EC2インスタンス
# - セキュリティグループ
# など
# ===================================
EOF