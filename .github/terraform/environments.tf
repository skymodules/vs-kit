# GitHub Environment Configuration

# 🌌 [PR Environment](https://skymodules.hashnode.space/default-guide/pr-environment-environment-type)
resource "github_repository_environment" "pr" {
  count               = var.pr_environment.enabled ? 1 : 0
  repository          = data.github_repository.this.name
  environment         = var.pr_environment.name
  prevent_self_review = true
  deployment_branch_policy {
    protected_branches     = false
    custom_branch_policies = true
  }
}

resource "github_actions_environment_variable" "pr" {
  count         = var.pr_environment.enabled ? 1 : 0
  repository    = data.github_repository.this.name
  environment   = try(github_repository_environment.pr[0].environment, null)
  variable_name = "SDLC_ENVIRONMENT"
  value         = var.pr_environment.name
}

# 🌌 [Test Environment](https://skymodules.hashnode.space/default-guide/test-environment-environment-type)
resource "github_repository_environment" "test" {
  count               = var.test_environment.enabled ? 1 : 0
  repository          = data.github_repository.this.name
  environment         = var.test_environment.name
  prevent_self_review = true
  deployment_branch_policy {
    protected_branches     = false
    custom_branch_policies = true
  }
}

resource "github_actions_environment_variable" "test" {
  count         = var.pr_environment.enabled ? 1 : 0
  repository    = data.github_repository.this.name
  environment   = try(github_repository_environment.test[0].environment, null)
  variable_name = "SDLC_ENVIRONMENT"
  value         = var.test_environment.name
}

# 🌌 [Live Environment](https://skymodules.hashnode.space/default-guide/live-environment-environment-type)
resource "github_repository_environment" "live" {
  count               = var.test_environment.enabled ? 1 : 0
  repository          = data.github_repository.this.name
  environment         = var.test_environment.name
  prevent_self_review = true
  deployment_branch_policy {
    protected_branches     = false
    custom_branch_policies = true
  }
}

resource "github_actions_environment_variable" "live" {
  count         = var.live_environment.enabled ? 1 : 0
  repository    = data.github_repository.this.name
  environment   = try(github_repository_environment.live[0].environment, null)
  variable_name = "SDLC_ENVIRONMENT"
  value         = var.live_environment.name
}
