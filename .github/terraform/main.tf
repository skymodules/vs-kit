# Repository
data "github_repository" "this" {
  full_name = var.GITHUB_REPOSITORY
}

resource "github_actions_variable" "owner" {
  repository    = data.github_repository.this.name
  variable_name = "organization_name"
  value         = var.GITHUB_OWNER
}

resource "github_actions_variable" "project" {
  repository    = data.github_repository.this.name
  variable_name = "organization_name"
  value         = var.GITHUB_REPOSITORY
}


# environments
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
