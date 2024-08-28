## APP

output "app_arn" {
  value = try(
    aws_amplify_app.this.*.arn
  )
}

output "app_name" {
  value = try(
    aws_amplify_app.this.*.name
  )
}

output "app_access_token" {
  value = try(
    aws_amplify_app.this.*.access_token
  )
}

## BACKEND ENVIRONMENT

output "backend_environment_arn" {
  value = try(
    aws_amplify_backend_environment.this.*.arn
  )
}

output "backed_environment_id" {
  value = try(
    aws_amplify_backend_environment.this.*.id
  )
}

output "backend_environment_app_id" {
  value = try(
    aws_amplify_backend_environment.this.*.app_id
  )
}

## BRANCH

output "branch_name" {
  value = try(
    aws_amplify_branch.this.*.branch_name
  )
}

output "branch_id" {
  value = try(
    aws_amplify_branch.this.*.id
  )
}

## DOMAIN ASSOCIATION

output "domain_association_id" {
  value = try(
    aws_amplify_domain_association.this.*.id
  )
}

output "domain_association_arn" {
  value = try(
    aws_amplify_domain_association.this.*.arn
  )
}

## WEBHOOK

output "webhook_arn" {
  value = try(
    aws_amplify_webhook.this.*.arn
  )
}

output "webhook_id" {
  value = try(
    aws_amplify_webhook.this.*.id
  )
}