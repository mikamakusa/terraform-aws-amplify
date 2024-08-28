## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.64.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.64.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acm"></a> [acm](#module\_acm) | ./modules/terraform-aws-acm | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_amplify_app.this](https://registry.terraform.io/providers/hashicorp/aws/5.64.0/docs/resources/amplify_app) | resource |
| [aws_amplify_backend_environment.this](https://registry.terraform.io/providers/hashicorp/aws/5.64.0/docs/resources/amplify_backend_environment) | resource |
| [aws_amplify_branch.this](https://registry.terraform.io/providers/hashicorp/aws/5.64.0/docs/resources/amplify_branch) | resource |
| [aws_amplify_domain_association.this](https://registry.terraform.io/providers/hashicorp/aws/5.64.0/docs/resources/amplify_domain_association) | resource |
| [aws_amplify_webhook.this](https://registry.terraform.io/providers/hashicorp/aws/5.64.0/docs/resources/amplify_webhook) | resource |
| [aws_default_tags.this](https://registry.terraform.io/providers/hashicorp/aws/5.64.0/docs/data-sources/default_tags) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app"></a> [app](#input\_app) | n/a | <pre>list(object({<br>    id                            = number<br>    name                          = string<br>    access_token                  = optional(string)<br>    auto_branch_creation_patterns = optional(list(string))<br>    basic_auth_credentials        = optional(string)<br>    build_spec                    = optional(string)<br>    custom_headers                = optional(string)<br>    description                   = optional(string)<br>    enable_auto_branch_creation   = optional(bool)<br>    enable_basic_auth             = optional(bool)<br>    enable_branch_auto_build      = optional(bool)<br>    enable_branch_auto_deletion   = optional(bool)<br>    environment_variables         = optional(map(string))<br>    iam_service_role_arn          = optional(string)<br>    oauth_token                   = optional(string)<br>    platform                      = optional(string)<br>    repository                    = optional(string)<br>    tags                          = optional(map(string))<br>    auto_branch_creation_config = optional(list(object({<br>      basic_auth_credentials        = optional(string)<br>      build_spec                    = optional(string)<br>      enable_auto_build             = optional(bool)<br>      enable_basic_auth             = optional(bool)<br>      enable_performance_mode       = optional(bool)<br>      enable_pull_request_preview   = optional(bool)<br>      environment_variables         = optional(map(string))<br>      framework                     = optional(string)<br>      pull_request_environment_name = optional(string)<br>      stage                         = optional(string)<br>    })))<br>    custom_rule = optional(list(object({<br>      source    = string<br>      target    = string<br>      condition = optional(string)<br>      status    = optional(string)<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_backend_environment"></a> [backend\_environment](#input\_backend\_environment) | n/a | <pre>list(object({<br>    id                   = number<br>    app_id               = any<br>    environment_name     = string<br>    deployment_artifacts = optional(string)<br>    stack_name           = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_branch"></a> [branch](#input\_branch) | n/a | <pre>list(object({<br>    id                            = number<br>    app_id                        = any<br>    branch_name                   = string<br>    backend_environment_arn       = optional(string)<br>    basic_auth_credentials        = optional(string)<br>    description                   = optional(string)<br>    display_name                  = optional(string)<br>    enable_auto_build             = optional(bool)<br>    enable_basic_auth             = optional(bool)<br>    enable_notification           = optional(bool)<br>    enable_performance_mode       = optional(bool)<br>    enable_pull_request_preview   = optional(bool)<br>    environment_variables         = optional(map(string))<br>    framework                     = optional(string)<br>    pull_request_environment_name = optional(string)<br>    stage                         = optional(string)<br>    tags                          = optional(map(string))<br>    ttl                           = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_certficate"></a> [certficate](#input\_certficate) | n/a | `any` | n/a | yes |
| <a name="input_domain_association"></a> [domain\_association](#input\_domain\_association) | n/a | <pre>list(object({<br>    id                     = number<br>    app_id                 = any<br>    domain_name            = string<br>    enable_auto_sub_domain = optional(bool)<br>    wait_for_verification  = optional(bool)<br>    certificates_settings = optional(list(object({<br>      type                   = string<br>      custom_certificate_id = optional(any)<br>    })))<br>    sub_domain = optional(list(object({<br>      branch_id = any<br>      prefix    = string<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_webhook"></a> [webhook](#input\_webhook) | n/a | <pre>list(object({<br>    id          = number<br>    app_id      = any<br>    branch_id   = any<br>    description = optional(string)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_access_token"></a> [app\_access\_token](#output\_app\_access\_token) | n/a |
| <a name="output_app_arn"></a> [app\_arn](#output\_app\_arn) | n/a |
| <a name="output_app_name"></a> [app\_name](#output\_app\_name) | n/a |
| <a name="output_backed_environment_id"></a> [backed\_environment\_id](#output\_backed\_environment\_id) | n/a |
| <a name="output_backend_environment_app_id"></a> [backend\_environment\_app\_id](#output\_backend\_environment\_app\_id) | n/a |
| <a name="output_backend_environment_arn"></a> [backend\_environment\_arn](#output\_backend\_environment\_arn) | n/a |
| <a name="output_branch_id"></a> [branch\_id](#output\_branch\_id) | n/a |
| <a name="output_branch_name"></a> [branch\_name](#output\_branch\_name) | n/a |
| <a name="output_domain_association_arn"></a> [domain\_association\_arn](#output\_domain\_association\_arn) | n/a |
| <a name="output_domain_association_id"></a> [domain\_association\_id](#output\_domain\_association\_id) | n/a |
| <a name="output_webhook_arn"></a> [webhook\_arn](#output\_webhook\_arn) | n/a |
| <a name="output_webhook_id"></a> [webhook\_id](#output\_webhook\_id) | n/a |
