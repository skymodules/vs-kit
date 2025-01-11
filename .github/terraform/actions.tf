# GitHub Actions Configuration
resource "github_actions_repository_permissions" "this" {
  allowed_actions = "selected"
  allowed_actions_config {
    github_owned_allowed = true
    patterns_allowed     = ["actions/cache@*", "actions/checkout@*"]
    verified_allowed     = true
  }
  repository = data.github_repository.this.name
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
