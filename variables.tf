variable "lighthouse_definitions" {
  description = <<EOT
Map of lighthouse_definitions, attributes below
Required:
    - managing_tenant_id
    - name
    - scope
    - authorization (block):
        - delegated_role_definition_ids (optional)
        - principal_display_name (optional)
        - principal_id (required)
        - role_definition_id (required)
Optional:
    - description
    - lighthouse_definition_id
    - eligible_authorization (block):
        - just_in_time_access_policy (optional, block):
            - approver (optional, block):
                - principal_display_name (optional)
                - principal_id (required)
            - maximum_activation_duration (optional)
            - multi_factor_auth_provider (optional)
        - principal_display_name (optional)
        - principal_id (required)
        - role_definition_id (required)
    - plan (block):
        - name (required)
        - product (required)
        - publisher (required)
        - version (required)
EOT

  type = map(object({
    managing_tenant_id       = string
    name                     = string
    scope                    = string
    description              = optional(string)
    lighthouse_definition_id = optional(string)
    authorization = list(object({
      delegated_role_definition_ids = optional(set(string))
      principal_display_name        = optional(string)
      principal_id                  = string
      role_definition_id            = string
    }))
    eligible_authorization = optional(list(object({
      just_in_time_access_policy = optional(object({
        approver = optional(list(object({
          principal_display_name = optional(string)
          principal_id           = string
        })))
        maximum_activation_duration = optional(string)
        multi_factor_auth_provider  = optional(string)
      }))
      principal_display_name = optional(string)
      principal_id           = string
      role_definition_id     = string
    })))
    plan = optional(object({
      name      = string
      product   = string
      publisher = string
      version   = string
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.lighthouse_definitions : (
        length(v.authorization) >= 1
      )
    ])
    error_message = "Each authorization list must contain at least 1 items"
  }
  # --- Unconfirmed validation candidates, derived from azurerm_lighthouse_definition's provider source ---
  # Not auto-enabled: either a bespoke provider validator we can't safely translate,
  # or a path that crosses a list-typed block (needs its own for_each wrapping).
  # Review, translate into a real validation{} block above, and delete once confirmed.
  # path: name
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: managing_tenant_id
  #   condition: can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", value))
  #   message:   must be a valid UUID
  # path: scope
  #   source:    [from commonids.ValidateSubscriptionID] !ok
  # path: scope
  #   source:    [from commonids.ValidateSubscriptionID] err != nil
  # path: authorization.principal_id
  #   condition: can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", value))
  #   message:   must be a valid UUID
  # path: authorization.role_definition_id
  #   condition: can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", value))
  #   message:   must be a valid UUID
  # path: authorization.principal_display_name
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: authorization.delegated_role_definition_ids[*]
  #   condition: can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", value))
  #   message:   must be a valid UUID
  # path: eligible_authorization.principal_id
  #   condition: can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", value))
  #   message:   must be a valid UUID
  # path: eligible_authorization.role_definition_id
  #   condition: can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", value))
  #   message:   must be a valid UUID
  # path: eligible_authorization.just_in_time_access_policy.multi_factor_auth_provider
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: eligible_authorization.just_in_time_access_policy.maximum_activation_duration
  #   source:    [from azValidate.ISO8601Duration] !ok
  # path: eligible_authorization.just_in_time_access_policy.maximum_activation_duration
  #   source:    [from azValidate.ISO8601Duration] err != nil
  # path: eligible_authorization.just_in_time_access_policy.approver.principal_id
  #   condition: can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", value))
  #   message:   must be a valid UUID
  # path: eligible_authorization.just_in_time_access_policy.approver.principal_display_name
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: eligible_authorization.principal_display_name
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: lighthouse_definition_id
  #   condition: can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", value))
  #   message:   must be a valid UUID
  # path: plan.name
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: plan.publisher
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: plan.product
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: plan.version
  #   condition: length(value) > 0
  #   message:   must not be empty
}

