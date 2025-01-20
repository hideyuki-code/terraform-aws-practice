variable "project" {
  type        = string
  description = "Project name"
  default     = "terraform-practice"
}

variable "environment" {
  type        = string
  description = "Environment (dev/stg/prod)"
  default     = "dev"
}

variable "region" {
  type        = string
  description = "AWS Region"
  default     = "ap-southeast-2"
}

variable "vpc_cidr" {
  description = "VPCのCIDRブロック"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "VPCの名前"
  type        = string
}

variable "azs" {
  type        = list(string)
  description = "使用するアベイラビリティゾーン"
  default     = ["ap-southeast-2a", "ap-southeast-2c"]
}

variable "public_subnets" {
  type        = list(string)
  description = "パブリックサブネットのCIDRブロックリスト"
  default     = ["10.0.0.0/20", "10.0.16.0/20"]
}

variable "private_subnets" {
  type        = list(string)
  description = "プライベートサブネットのCIDRブロックリスト"
  default     = ["10.0.64.0/20", "10.0.80.0/20"]
}

variable "tags" {
  type        = map(string)
  description = "リソースに付与する共通タグ"
  default = {
    ManagedBy = "Terraform"
  }
}