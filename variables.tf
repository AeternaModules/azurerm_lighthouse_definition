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
    eligible_authorization = optional(object({
      just_in_time_access_policy = optional(object({
        approver = optional(object({
          principal_display_name = optional(string)
          principal_id           = string
        }))
        maximum_activation_duration = optional(string) # Default: "PT8H"
        multi_factor_auth_provider  = optional(string)
      }))
      principal_display_name = optional(string)
      principal_id           = string
      role_definition_id     = string
    }))
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
}

