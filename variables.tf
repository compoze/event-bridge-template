variable "production" {
  description = "Is that a production environment?"
  type        = bool
  default     = false
}

variable "environment" {
  default = "dev"
}

variable "region" {
  default = "us-east-1"
}
variable "queue_name" {
  default = "component-name"
}

variable "project_name" {
  default = "test-org-compoze"
}

variable "receivers" {
  type    = list
}
