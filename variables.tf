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
  validation {
    condition = alltrue([
      for k, v in var.lighthouse_definitions : (
        length(v.name) > 0
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.lighthouse_definitions : (
        can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", v.managing_tenant_id))
      )
    ])
    error_message = "must be a valid UUID"
  }
  validation {
    condition = alltrue([
      for k, v in var.lighthouse_definitions : (
        alltrue([for item in v.authorization : (can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", item.principal_id)))])
      )
    ])
    error_message = "must be a valid UUID"
  }
  validation {
    condition = alltrue([
      for k, v in var.lighthouse_definitions : (
        alltrue([for item in v.authorization : (can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", item.role_definition_id)))])
      )
    ])
    error_message = "must be a valid UUID"
  }
  validation {
    condition = alltrue([
      for k, v in var.lighthouse_definitions : (
        alltrue([for item in v.authorization : (item.principal_display_name == null || (length(item.principal_display_name) > 0))])
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.lighthouse_definitions : (
        alltrue([for item in v.authorization : (item.delegated_role_definition_ids == null || (alltrue([for x in item.delegated_role_definition_ids : can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", x))])))])
      )
    ])
    error_message = "must be a valid UUID"
  }
  validation {
    condition = alltrue([
      for k, v in var.lighthouse_definitions : (
        v.eligible_authorization == null || alltrue([for item in v.eligible_authorization : (can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", item.principal_id)))])
      )
    ])
    error_message = "must be a valid UUID"
  }
  validation {
    condition = alltrue([
      for k, v in var.lighthouse_definitions : (
        v.eligible_authorization == null || alltrue([for item in v.eligible_authorization : (can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", item.role_definition_id)))])
      )
    ])
    error_message = "must be a valid UUID"
  }
  validation {
    condition = alltrue([
      for k, v in var.lighthouse_definitions : (
        v.eligible_authorization == null || alltrue([for item in v.eligible_authorization : (item.just_in_time_access_policy == null || (item.just_in_time_access_policy.approver == null || alltrue([for item in item.just_in_time_access_policy.approver : (can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", item.principal_id)))])))])
      )
    ])
    error_message = "must be a valid UUID"
  }
  validation {
    condition = alltrue([
      for k, v in var.lighthouse_definitions : (
        v.eligible_authorization == null || alltrue([for item in v.eligible_authorization : (item.just_in_time_access_policy == null || (item.just_in_time_access_policy.approver == null || alltrue([for item in item.just_in_time_access_policy.approver : (item.principal_display_name == null || (length(item.principal_display_name) > 0))])))])
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.lighthouse_definitions : (
        v.eligible_authorization == null || alltrue([for item in v.eligible_authorization : (item.principal_display_name == null || (length(item.principal_display_name) > 0))])
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.lighthouse_definitions : (
        v.lighthouse_definition_id == null || (can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", v.lighthouse_definition_id)))
      )
    ])
    error_message = "must be a valid UUID"
  }
  validation {
    condition = alltrue([
      for k, v in var.lighthouse_definitions : (
        v.plan == null || (length(v.plan.name) > 0)
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.lighthouse_definitions : (
        v.plan == null || (length(v.plan.publisher) > 0)
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.lighthouse_definitions : (
        v.plan == null || (length(v.plan.product) > 0)
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.lighthouse_definitions : (
        v.plan == null || (length(v.plan.version) > 0)
      )
    ])
    error_message = "must not be empty"
  }
  # Note: 5 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

