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
    PR Environment settings
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

variable "test_environment" {
  description = <<DESCRIPTION
    Test Environment settings
  DESCRIPTION
  type = object({
    name    = string
    enabled = bool
  })

  default = {
    name    = "test"
    enabled = true
  }
}

variable "live_environment" {
  description = <<DESCRIPTION
    Live Environment settings
  DESCRIPTION
  type = object({
    name    = string
    enabled = bool
  })

  default = {
    name    = "live"
    enabled = true
  }
}
