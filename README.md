# 😎 VSKit (Visual Studio Code Kit)

**VSKit** is an advanced, intelligent development kit designed for Visual Studio Code. It simplifies the creation of containerized solutions by automating the entire lifecycle— from local development to deployment. With VSKit, you can seamlessly manage your development environment, CI/CD pipelines, and container registry integration.

🌌 SkyModules.io VS Kits:

## 😎 Key Features

- **VS Code Dev Containers**: Streamlined setup for development within containers.
- **GitHub Integration**: Full support for GitHub Actions, SSH integration, and secrets management.

## Quick Start Guide

Github Authentication:

In your host system

Run the [DevContainer](https://code.visualstudio.com/docs/devcontainers/containers) in VS Code to get started with [VS-Kit](https://github.com/skymodules/vs-kit). The DevContainer provides a pre-configured environment with all the tools you need to start developing containerized applications. You can then use the integrated [GitHub Actions](https://docs.github.com/en/actions) to automate your CI/CD pipelines and deploy your containers to the cloud.

## How It Works

VSKit simplifies container development by integrating:

- **Dev Containers**: Pre-configured container environments for VS Code.
- **GitHub Actions**: Automate builds, tests, and deployments using GitHub CI/CD.
- **GitHub Container Registry**: Manage container images directly from GitHub Packages.

## Features

- **Local Automation**

  - [VS Code](https://code.visualstudio.com/): Development environment.
  - [Makefile](https://www.gnu.org/software/make/): Project automation and task management.
  - [Trunk.io](https://trunk.io/): Code quality and security analysis.
  - [CodeQL](https://securitylab.github.com/tools/codeql): Code quality and security analysis.
  - [Prettier](https://prettier.io/): Code formatting.
  - [ShellCheck](https://www.shellcheck.net/): Shell script analysis.
  - [YAML Lint](https://yamllint.readthedocs.io/en/stable/): YAML linting.

- **GitHub Automation**
  - [Github Terraform](.github/workflows): GitHub repository automation via Terraform.
  - [Github Workflows](.github/workflows): CI/CD, Project, and other workflows.

### Local Automation

Dev Containers

- [DevContainer](https://code.visualstudio.com/docs/remote/containers): Pre-configured container environments for VS Code.
  - [Ubuntu 22](https://hub.docker.com/_/ubuntu): Base image for development.
  - [Microsoft Artifact Registry](https://mcr.microsoft.com/en-us/)

### Configuration

Environment Variables

- [DotEnvX](https://dotenvx.com/): Manage environment variables.
- [GitHub Actions Variables](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/store-information-in-variables): Secure secrets management.

Secrets Management

- [Doppler](https://doppler.com/): Secure secrets management.
- [Vault](https://www.hashicorp.com/products/vault): Secure secret management.
- [GitHub Actions Secrets](https://docs.github.com/en/actions/reference/encrypted-secrets): Secure secrets management.

## License

VSKit is licensed under the [MIT License](LICENSE).

---

This Starter-Kit will be used to create others via forks.
