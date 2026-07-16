output "lighthouse_definitions_id" {
  description = "Map of id values across all lighthouse_definitions, keyed the same as var.lighthouse_definitions"
  value       = { for k, v in azurerm_lighthouse_definition.lighthouse_definitions : k => v.id if v.id != null && length(v.id) > 0 }
}
output "lighthouse_definitions_authorization" {
  description = "Map of authorization values across all lighthouse_definitions, keyed the same as var.lighthouse_definitions"
  value       = { for k, v in azurerm_lighthouse_definition.lighthouse_definitions : k => v.authorization if v.authorization != null && length(v.authorization) > 0 }
}
output "lighthouse_definitions_description" {
  description = "Map of description values across all lighthouse_definitions, keyed the same as var.lighthouse_definitions"
  value       = { for k, v in azurerm_lighthouse_definition.lighthouse_definitions : k => v.description if v.description != null && length(v.description) > 0 }
}
output "lighthouse_definitions_eligible_authorization" {
  description = "Map of eligible_authorization values across all lighthouse_definitions, keyed the same as var.lighthouse_definitions"
  value       = { for k, v in azurerm_lighthouse_definition.lighthouse_definitions : k => v.eligible_authorization if v.eligible_authorization != null && length(v.eligible_authorization) > 0 }
}
output "lighthouse_definitions_lighthouse_definition_id" {
  description = "Map of lighthouse_definition_id values across all lighthouse_definitions, keyed the same as var.lighthouse_definitions"
  value       = { for k, v in azurerm_lighthouse_definition.lighthouse_definitions : k => v.lighthouse_definition_id if v.lighthouse_definition_id != null && length(v.lighthouse_definition_id) > 0 }
}
output "lighthouse_definitions_managing_tenant_id" {
  description = "Map of managing_tenant_id values across all lighthouse_definitions, keyed the same as var.lighthouse_definitions"
  value       = { for k, v in azurerm_lighthouse_definition.lighthouse_definitions : k => v.managing_tenant_id if v.managing_tenant_id != null && length(v.managing_tenant_id) > 0 }
}
output "lighthouse_definitions_name" {
  description = "Map of name values across all lighthouse_definitions, keyed the same as var.lighthouse_definitions"
  value       = { for k, v in azurerm_lighthouse_definition.lighthouse_definitions : k => v.name if v.name != null && length(v.name) > 0 }
}
output "lighthouse_definitions_plan" {
  description = "Map of plan values across all lighthouse_definitions, keyed the same as var.lighthouse_definitions"
  value       = { for k, v in azurerm_lighthouse_definition.lighthouse_definitions : k => v.plan if v.plan != null && length(v.plan) > 0 }
}
output "lighthouse_definitions_scope" {
  description = "Map of scope values across all lighthouse_definitions, keyed the same as var.lighthouse_definitions"
  value       = { for k, v in azurerm_lighthouse_definition.lighthouse_definitions : k => v.scope if v.scope != null && length(v.scope) > 0 }
}

