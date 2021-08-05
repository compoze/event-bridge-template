# EventBus
output "eventbridge_bus_arn" {
  description = "The ARN of the EventBridge"
  value       = module.eventbridge.eventbridge_bus_arn
}

output "eventbridge_bus_name" {
  description = "The Name of the EventBridge"
  value       = module.eventbridge.eventbridge_bus_name
}

output "eventbridge_role_arn" {
  description = "The ARN of the EventBridge role"
  value       = module.eventbridge.eventbridge_role_arn
}

output "eventbridge_role_name" {
  description = "The Name of the EventBridge role"
  value       = module.eventbridge.eventbridge_role_name
}

output "eventbridge_rule_arns" {
  description = "The ARNs of the EventBridge rules"
  value       = module.eventbridge.eventbridge_rule_arns
}

output "eventbridge_rule_ids" {
  description = "The Ids of the EventBridge rules"
  value       = module.eventbridge.eventbridge_rule_ids
}
