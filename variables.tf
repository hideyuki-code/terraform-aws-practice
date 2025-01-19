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