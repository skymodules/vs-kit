variable "GITHUB_OWNER" {
  description = "The owner of this repository"
  type        = string
}

variable "GITHUB_REPOSITORY" {
  description = "The name of this repository"
  type        = string
}

variable "pr_environment" {
  description = <<DESCRIPTION
    The name of the environment to deploy the pull request to.
  DESCRIPTION
  type = object({
    name    = string
    enabled = bool
  })

  default = {
    name    = "pr"
    enabled = true
  }
}
