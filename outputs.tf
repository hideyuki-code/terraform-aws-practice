cat << EOF > outputs.tf
# ===================================
# Outputs（出力）の定義
# 
# ここには、他の開発者が必要とする情報や
# 作成したリソースの重要な情報を出力として定義します
#
# 出力例：
# output "vpc_id" {
#   value       = aws_vpc.main.id
#   description = "作成したVPCのID"
# }
#
# output "public_ip" {
#   value       = aws_instance.web.public_ip
#   description = "EC2インスタンスのパブリックIP"
# }
# ===================================
EOF