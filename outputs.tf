output "lighthouse_definitions_authorization" {
  description = "Map of authorization values across all lighthouse_definitions, keyed the same as var.lighthouse_definitions"
  value       = { for k, v in azurerm_lighthouse_definition.lighthouse_definitions : k => v.authorization }
}
output "lighthouse_definitions_description" {
  description = "Map of description values across all lighthouse_definitions, keyed the same as var.lighthouse_definitions"
  value       = { for k, v in azurerm_lighthouse_definition.lighthouse_definitions : k => v.description }
}
output "lighthouse_definitions_eligible_authorization" {
  description = "Map of eligible_authorization values across all lighthouse_definitions, keyed the same as var.lighthouse_definitions"
  value       = { for k, v in azurerm_lighthouse_definition.lighthouse_definitions : k => v.eligible_authorization }
}
output "lighthouse_definitions_lighthouse_definition_id" {
  description = "Map of lighthouse_definition_id values across all lighthouse_definitions, keyed the same as var.lighthouse_definitions"
  value       = { for k, v in azurerm_lighthouse_definition.lighthouse_definitions : k => v.lighthouse_definition_id }
}
output "lighthouse_definitions_managing_tenant_id" {
  description = "Map of managing_tenant_id values across all lighthouse_definitions, keyed the same as var.lighthouse_definitions"
  value       = { for k, v in azurerm_lighthouse_definition.lighthouse_definitions : k => v.managing_tenant_id }
}
output "lighthouse_definitions_name" {
  description = "Map of name values across all lighthouse_definitions, keyed the same as var.lighthouse_definitions"
  value       = { for k, v in azurerm_lighthouse_definition.lighthouse_definitions : k => v.name }
}
output "lighthouse_definitions_plan" {
  description = "Map of plan values across all lighthouse_definitions, keyed the same as var.lighthouse_definitions"
  value       = { for k, v in azurerm_lighthouse_definition.lighthouse_definitions : k => v.plan }
}
output "lighthouse_definitions_scope" {
  description = "Map of scope values across all lighthouse_definitions, keyed the same as var.lighthouse_definitions"
  value       = { for k, v in azurerm_lighthouse_definition.lighthouse_definitions : k => v.scope }
}

