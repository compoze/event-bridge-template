provider "aws" {
  region = var.region
}

provider "aws" {
  alias  = "secrets"
  region = "us-east-1"
}

locals {
  queue_name        = "${var.queue_name}-${var.environment}"
  environment       = var.environment
  project_name      = var.project_name
  infra_environment = "prod" # default infrastructure environment is production. 
  # route53 will generally always be production (could eventually remove environment enitrely)
  # but for  remaining environments we will default to prod for MVP
  common_tags = {
    Name        = local.queue_name
    Application = var.queue_name
    Environment = var.environment
    Terraform   = "cloud"
  }
}

