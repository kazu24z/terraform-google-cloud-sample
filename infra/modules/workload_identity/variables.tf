variable "project_id" {
  description = "プロジェクトID"
}

variable "project_number" {
  description = "GCPプロジェクト番号"
}

variable "service_account_infra" {
  description = "GitHub Actionsが利用するSA"
}

variable "service_account_app" {
  description = "GitHub Actionsが利用するSA"
}
