
# [GitHub Labels](https://docs.github.com/en/rest/reference/issues#labels)
resource "github_issue_label" "urgent" {
  repository = "test-repo"
  name       = "Urgent"
  color      = "FF0000"
}
