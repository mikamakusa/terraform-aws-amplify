## TAGS

variable "tags" {
  type    = map(string)
  default = {}
}

## MODULES

variable "certficate" {
  type = any
}

## RESOURCES

variable "app" {
  type = list(object({
    id                            = number
    name                          = string
    access_token                  = optional(string)
    auto_branch_creation_patterns = optional(list(string))
    basic_auth_credentials        = optional(string)
    build_spec                    = optional(string)
    custom_headers                = optional(string)
    description                   = optional(string)
    enable_auto_branch_creation   = optional(bool)
    enable_basic_auth             = optional(bool)
    enable_branch_auto_build      = optional(bool)
    enable_branch_auto_deletion   = optional(bool)
    environment_variables         = optional(map(string))
    iam_service_role_arn          = optional(string)
    oauth_token                   = optional(string)
    platform                      = optional(string)
    repository                    = optional(string)
    tags                          = optional(map(string))
    auto_branch_creation_config = optional(list(object({
      basic_auth_credentials        = optional(string)
      build_spec                    = optional(string)
      enable_auto_build             = optional(bool)
      enable_basic_auth             = optional(bool)
      enable_performance_mode       = optional(bool)
      enable_pull_request_preview   = optional(bool)
      environment_variables         = optional(map(string))
      framework                     = optional(string)
      pull_request_environment_name = optional(string)
      stage                         = optional(string)
    })))
    custom_rule = optional(list(object({
      source    = string
      target    = string
      condition = optional(string)
      status    = optional(string)
    })))
  }))
  default = []

  validation {
    condition     = length([for a in var.app : true if contains(["WEB", "WEB_COMPUTE"], a.platform)]) == length(var.app)
    error_message = "Valid values: WEB, WEB_COMPUTE."
  }

  validation {
    condition     = length([for b in var.app : true if contains(["PRODUCTION", "BETA", "DEVELOPMENT", "EXPERIMENTAL", "PULL_REQUEST"], b.auto_branch_creation_config.stage)]) == length(var.app)
    error_message = "Valid values: PRODUCTION, BETA, DEVELOPMENT, EXPERIMENTAL, PULL_REQUEST."
  }

  validation {
    condition     = length([for c in var.app : true if contains(["200", "301", "302", "404", "404-200"], c.custom_rule.status)]) == length(var.app)
    error_message = "Valid values: 200, 301, 302, 404, 404-200."
  }
}

variable "backend_environment" {
  type = list(object({
    id                   = number
    app_id               = any
    environment_name     = string
    deployment_artifacts = optional(string)
    stack_name           = optional(string)
  }))
  default = []
}

variable "branch" {
  type = list(object({
    id                            = number
    app_id                        = any
    branch_name                   = string
    backend_environment_arn       = optional(string)
    basic_auth_credentials        = optional(string)
    description                   = optional(string)
    display_name                  = optional(string)
    enable_auto_build             = optional(bool)
    enable_basic_auth             = optional(bool)
    enable_notification           = optional(bool)
    enable_performance_mode       = optional(bool)
    enable_pull_request_preview   = optional(bool)
    environment_variables         = optional(map(string))
    framework                     = optional(string)
    pull_request_environment_name = optional(string)
    stage                         = optional(string)
    tags                          = optional(map(string))
    ttl                           = optional(string)
  }))
  default = []

  validation {
    condition     = length([for a in var.branch : true if contains(["PRODUCTION", "BETA", "DEVELOPMENT", "EXPERIMENTAL", "PULL_REQUEST"], a.stage)]) == length(var.branch)
    error_message = "Valid values: PRODUCTION, BETA, DEVELOPMENT, EXPERIMENTAL, PULL_REQUEST."
  }
}

variable "domain_association" {
  type = list(object({
    id                     = number
    app_id                 = any
    domain_name            = string
    enable_auto_sub_domain = optional(bool)
    wait_for_verification  = optional(bool)
    certificates_settings = optional(list(object({
      type                   = string
      custom_certificate_id = optional(any)
    })))
    sub_domain = optional(list(object({
      branch_id = any
      prefix    = string
    })))
  }))
  default = []

  validation {
    condition     = length([for a in var.domain_association : true if contains(["AMPLIFY_MANAGED", "CUSTOM"], a.certificates_settings.type)]) == length(var.domain_association)
    error_message = "Valid values are AMPLIFY_MANAGED and CUSTOM."
  }
}

variable "webhook" {
  type = list(object({
    id          = number
    app_id      = any
    branch_id   = any
    description = optional(string)
  }))
  default = []
}
