output "full_name" {
    description = "The full name of this repository"
    value = data.github_repository.this.full_name
}