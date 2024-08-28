run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "amplify" {
  command = plan

  variables {
    tags = {
      terraform = "true"
      provider  = "aws"
      service   = "amplify"
    }
    app = [
      {
        id                      = 0
        name                    = "example"
        enable_basic_auth       = true
        basic_auth_credentials  = "username1:password1"
        environment_variables = {
          "_CUSTOM_IMAGE" = "node:16",
        }
        custom_rule = [
          {
            source = "/api/<*>"
            status = "200"
            target = "https://api.example.com/api/<*>"
          }
        ]
      }
    ]
    backend_environment = [
      {
        id                    = 0
        app_id                = 0
        environment_name      = "example"
        deployment_artifacts  = "app-example-deployment"
        stack_name            = "amplify-app-example"
      }
    ]
    branch = [
      {
        id          = 0
        app_id      = 0
        branch_name = "master"
        framework   = "React"
        stage       = "PRODUCTION"
        environment_variables = {
          REACT_APP_API_SERVER = "https://api.example.com"
        }
      }
    ]
    domain_association = [
      {
        id          = 0
        app_id      = 0
        domain_name = "example.com"
        sub_domain = [
          {
            branch_id   = 0
            prefix      = ""
          }
        ]
      }
    ]
    webhook = [
      {
        id          = 0
        app_id      = 0
        branch_id   = 0
        description = "triggermaster"
      }
    ]
  }
}