# GitHub Teams
resource "github_team" "main_team" {
  name        = "some-team"
  description = "Some cool team"
  privacy     = "closed"
}
