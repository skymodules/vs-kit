# Repository
data "github_repository" "this" {
  full_name = var.GITHUB_REPOSITORY
}

resource "github_actions_variable" "owner" {
  repository       = data.github_repository.this.name
  variable_name    = "organization_name"
  value            = var.GITHUB_OWNER
}

resource "github_actions_variable" "project" {
  repository       = data.github_repository.this.name
  variable_name    = "organization_name"
  value            = var.GITHUB_REPOSITORY
}