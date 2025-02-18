variable "region" {
  description = "Região AWS"
  type        = string
}

variable "secret_name" {
  description = "Nome do secret"
  type        = string
}

variable "secret_value" {
  description = "Valor do secret em JSON"
  type        = string
}