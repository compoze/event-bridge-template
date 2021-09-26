################################################################################
# Remove state configuration
################################################################################
terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "test-org-compoze"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = "${local.project_name}"
    workspaces = {
      name = "${local.project_name}-vpc-${local.infra_environment}"
    }
  }
}
################################################################################
# AWS EventBridge Module
################################################################################

resource "aws_sqs_queue" "deadletter_queue" {
  for_each = toset(var.receivers)

  name                        = "DLQ-${var.queue_name}-to-${each.key}"
  message_retention_seconds   = 1209600
  visibility_timeout_seconds  = 60
  fifo_queue                  = false
  content_based_deduplication = false
}

module "eventbridge" {
  source = "terraform-aws-modules/eventbridge/aws"

  bus_name = "${var.project_name}-${var.queue_name}-${var.environment}"

  rules = {
    events = {
      description   = "Capture all order data"
      event_pattern = jsonencode({ "account" : [data.aws_caller_identity.current.account_id] })
      enabled       = true
    }
  }

  targets = {
    events = concat([for receiver in var.receivers :
      { arn             = "arn:aws:lambda:${var.region}:${data.aws_caller_identity.current.account_id}:function:${receiver}"
        name            = "send-to-${receiver}"
        dead_letter_arn = aws_sqs_queue.deadletter_queue[receiver].arn
      }],
      [for receiver in var.receivers : { arn = "arn:aws:sqs:${var.region}:${data.aws_caller_identity.current.account_id}:${receiver}"
        name                                 = "send-to-${receiver}"
        dead_letter_arn                      = aws_sqs_queue.deadletter_queue[receiver].arn
        message_group_id                     = "send-to-${receiver}"
    }])
  }
}
