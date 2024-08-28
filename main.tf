resource "aws_amplify_app" "this" {
  count                         = length(var.app)
  name                          = lookup(var.app[count.index], "name")
  access_token                  = lookup(var.app[count.index], "access_token")
  auto_branch_creation_patterns = lookup(var.app[count.index], "auto_branch_creation_patterns")
  basic_auth_credentials        = base64encode(lookup(var.app[count.index], "basic_auth_credentials"))
  build_spec                    = lookup(var.app[count.index], "build_spec")
  custom_headers                = lookup(var.app[count.index], "custom_headers")
  description                   = lookup(var.app[count.index], "description")
  enable_auto_branch_creation   = lookup(var.app[count.index], "enable_auto_branch_creation")
  enable_basic_auth             = lookup(var.app[count.index], "enable_basic_auth")
  enable_branch_auto_build      = lookup(var.app[count.index], "enable_branch_auto_build")
  enable_branch_auto_deletion   = lookup(var.app[count.index], "enable_branch_auto_deletion")
  environment_variables         = lookup(var.app[count.index], "environment_variables")
  iam_service_role_arn          = lookup(var.app[count.index], "iam_service_role_arn")
  oauth_token                   = lookup(var.app[count.index], "oauth_token")
  platform                      = lookup(var.app[count.index], "platform", "WEB")
  repository                    = lookup(var.app[count.index], "repository")
  tags                          = merge(var.tags, data.aws_default_tags.this.tags, lookup(var.app[count.index], "tags"))

  dynamic "auto_branch_creation_config" {
    for_each = try(lookup(var.app[count.index], "auto_branch_creation_config") == null ? [] : ["auto_branch_creation_config"])
    iterator = auto
    content {
      basic_auth_credentials        = lookup(auto.value, "basic_auth_credentials")
      build_spec                    = lookup(auto.value, "build_spec")
      enable_auto_build             = lookup(auto.value, "enable_auto_build")
      enable_basic_auth             = lookup(auto.value, "enable_basic_auth")
      enable_performance_mode       = lookup(auto.value, "enable_performance_mode")
      enable_pull_request_preview   = lookup(auto.value, "enable_pull_request_preview")
      environment_variables         = lookup(auto.value, "environment_variables")
      framework                     = lookup(auto.value, "framework")
      pull_request_environment_name = lookup(auto.value, "pull_request_environment_name")
      stage                         = lookup(auto.value, "stage")
    }
  }

  dynamic "custom_rule" {
    for_each = try(lookup(var.app[count.index], "custom_rule") == null ? [] : ["custom_rule"])
    iterator = rule
    content {
      source    = lookup(rule.value, "source")
      target    = lookup(rule.value, "target")
      condition = lookup(rule.value, "condition")
      status    = lookup(rule.value, "status")
    }
  }
}

resource "aws_amplify_backend_environment" "this" {
  count                = length(var.app) == 0 ? 0 : length(var.backend_environment)
  app_id               = try(element(aws_amplify_app.this.*.id, lookup(var.backend_environment[count.index], "app_id")))
  environment_name     = lookup(var.backend_environment[count.index], "environment_name")
  deployment_artifacts = lookup(var.backend_environment[count.index], "deployment_artifacts")
  stack_name           = lookup(var.backend_environment[count.index], "stack_name")
}

resource "aws_amplify_branch" "this" {
  count                         = length(var.app) == 0 ? 0 : length(var.branch)
  app_id                        = try(element(aws_amplify_app.this.*.id, lookup(var.branch[count.index], "app_id")))
  branch_name                   = lookup(var.branch[count.index], "branch_name")
  backend_environment_arn       = lookup(var.branch[count.index], "backend_environment_arn")
  basic_auth_credentials        = lookup(var.branch[count.index], "basic_auth_credentials")
  description                   = lookup(var.branch[count.index], "description")
  display_name                  = lookup(var.branch[count.index], "display_name")
  enable_auto_build             = lookup(var.branch[count.index], "enable_auto_build")
  enable_basic_auth             = lookup(var.branch[count.index], "enable_basic_auth")
  enable_notification           = lookup(var.branch[count.index], "enable_notification")
  enable_performance_mode       = lookup(var.branch[count.index], "enable_performance_mode")
  enable_pull_request_preview   = lookup(var.branch[count.index], "enable_pull_request_preview")
  environment_variables         = lookup(var.branch[count.index], "environment_variables")
  framework                     = lookup(var.branch[count.index], "framework")
  pull_request_environment_name = lookup(var.branch[count.index], "pull_request_environment_name")
  stage                         = lookup(var.branch[count.index], "stage")
  tags                          = merge(var.tags, data.aws_default_tags.this.tags, lookup(var.branch[count.index], "tags"))
  ttl                           = lookup(var.branch[count.index], "ttl")
}

resource "aws_amplify_domain_association" "this" {
  count                  = length(var.app) == 0 ? 0 : length(var.domain_association)
  app_id                 = try(element(aws_amplify_app.this.*.id, lookup(var.domain_association[count.index], "app_id")))
  domain_name            = lookup(var.domain_association[count.index], "domain_name")
  enable_auto_sub_domain = lookup(var.domain_association[count.index], "enable_auto_sub_domain")
  wait_for_verification  = lookup(var.domain_association[count.index], "wait_for_verification", true)

  dynamic "certificates_settings" {
    for_each = try(lookup(var.domain_association[count.index], "certificates_settings") == null ? [] : ["certificates_settings"])
    iterator = cer
    content {
      type                   = lookup(cer.value, "type")
      custom_certificate_arn = try(element(module.acm.*.acm_certificate_arn, lookup(cer.value, "custom_certificate_id")))
    }
  }

  dynamic "sub_domain" {
    for_each = try(lookup(var.domain_association[count.index], "sub_domain") == null ? [] : ["sub_domain"])
    iterator = sub
    content {
      branch_name = try(element(aws_amplify_branch.this.*.branch_name, lookup(sub.value, "branch_id")))
      prefix      = lookup(sub.value, "prefix")
    }
  }
}

resource "aws_amplify_webhook" "this" {
  count       = (length(var.app) && length(var.branch)) == 0 ? 0 : length(var.webhook)
  app_id      = try(element(aws_amplify_app.this.*.id, lookup(var.webhook[count.index], "app_id")))
  branch_name = try(element(aws_amplify_branch.this.*.branch_name, lookup(var.webhook[count.index], "branch_id")))
  description = lookup(var.webhook[count.index], "description")
}