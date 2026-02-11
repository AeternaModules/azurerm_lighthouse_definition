resource "azurerm_lighthouse_definition" "lighthouse_definitions" {
  for_each = var.lighthouse_definitions

  managing_tenant_id       = each.value.managing_tenant_id
  name                     = each.value.name
  scope                    = each.value.scope
  description              = each.value.description
  lighthouse_definition_id = each.value.lighthouse_definition_id

  dynamic "authorization" {
    for_each = each.value.authorization
    content {
      delegated_role_definition_ids = authorization.value.delegated_role_definition_ids
      principal_display_name        = authorization.value.principal_display_name
      principal_id                  = authorization.value.principal_id
      role_definition_id            = authorization.value.role_definition_id
    }
  }

  dynamic "eligible_authorization" {
    for_each = each.value.eligible_authorization != null ? [each.value.eligible_authorization] : []
    content {
      dynamic "just_in_time_access_policy" {
        for_each = eligible_authorization.value.just_in_time_access_policy != null ? [eligible_authorization.value.just_in_time_access_policy] : []
        content {
          dynamic "approver" {
            for_each = just_in_time_access_policy.value.approver != null ? [just_in_time_access_policy.value.approver] : []
            content {
              principal_display_name = approver.value.principal_display_name
              principal_id           = approver.value.principal_id
            }
          }
          maximum_activation_duration = just_in_time_access_policy.value.maximum_activation_duration
          multi_factor_auth_provider  = just_in_time_access_policy.value.multi_factor_auth_provider
        }
      }
      principal_display_name = eligible_authorization.value.principal_display_name
      principal_id           = eligible_authorization.value.principal_id
      role_definition_id     = eligible_authorization.value.role_definition_id
    }
  }

  dynamic "plan" {
    for_each = each.value.plan != null ? [each.value.plan] : []
    content {
      name      = plan.value.name
      product   = plan.value.product
      publisher = plan.value.publisher
      version   = plan.value.version
    }
  }
}

