
# [GitHub Labels](https://docs.github.com/en/rest/reference/issues#labels)
resource "github_issue_label" "urgent" {
  repository = data.github_repository.this.name
  name       = "Urgent"
  color      = "FF0000"
}
