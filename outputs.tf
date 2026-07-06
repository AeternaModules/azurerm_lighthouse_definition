output "lighthouse_definitions" {
  description = "All lighthouse_definition resources"
  value       = azurerm_lighthouse_definition.lighthouse_definitions
}
output "lighthouse_definitions_authorization" {
  description = "List of authorization values across all lighthouse_definitions"
  value       = [for k, v in azurerm_lighthouse_definition.lighthouse_definitions : v.authorization]
}
output "lighthouse_definitions_description" {
  description = "List of description values across all lighthouse_definitions"
  value       = [for k, v in azurerm_lighthouse_definition.lighthouse_definitions : v.description]
}
output "lighthouse_definitions_eligible_authorization" {
  description = "List of eligible_authorization values across all lighthouse_definitions"
  value       = [for k, v in azurerm_lighthouse_definition.lighthouse_definitions : v.eligible_authorization]
}
output "lighthouse_definitions_lighthouse_definition_id" {
  description = "List of lighthouse_definition_id values across all lighthouse_definitions"
  value       = [for k, v in azurerm_lighthouse_definition.lighthouse_definitions : v.lighthouse_definition_id]
}
output "lighthouse_definitions_managing_tenant_id" {
  description = "List of managing_tenant_id values across all lighthouse_definitions"
  value       = [for k, v in azurerm_lighthouse_definition.lighthouse_definitions : v.managing_tenant_id]
}
output "lighthouse_definitions_name" {
  description = "List of name values across all lighthouse_definitions"
  value       = [for k, v in azurerm_lighthouse_definition.lighthouse_definitions : v.name]
}
output "lighthouse_definitions_plan" {
  description = "List of plan values across all lighthouse_definitions"
  value       = [for k, v in azurerm_lighthouse_definition.lighthouse_definitions : v.plan]
}
output "lighthouse_definitions_scope" {
  description = "List of scope values across all lighthouse_definitions"
  value       = [for k, v in azurerm_lighthouse_definition.lighthouse_definitions : v.scope]
}

