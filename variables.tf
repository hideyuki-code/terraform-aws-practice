cat << EOF > variables.tf
# プロジェクト名の変数定義
# この変数は、リソースの命名などで使用します
variable "project" {
  type        = string          # 文字列型として定義
  description = "Project name"  # 変数の説明
  default     = "terraform-practice"  # デフォルト値
}

# 環境名の変数定義
# dev/stg/prod など、環境を区別するために使用
variable "environment" {
  type        = string
  description = "Environment (dev/stg/prod)"  # 開発/ステージング/本番環境の区別
  default     = "dev"                         # デフォルトは開発環境
}

# ===================================
# 変数の使い方：
# リソース内で以下のように参照できます
# name = "\${var.project}-resource"
# tags = {
#   Environment = var.environment
# }
# ===================================
EOF