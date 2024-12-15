# 😎 VSKit (Visual Studio Code Kit)

**VSKit** is an advanced, intelligent development kit designed for Visual Studio Code. It simplifies the creation of containerized solutions by automating the entire lifecycle— from local development to deployment. With VSKit, you can seamlessly manage your development environment, CI/CD pipelines, and container registry integration.

🌌 SkyModules.io VS Kits:

## 😎 Key Features

- **VS Code Dev Containers**: Streamlined setup for development within containers.
- **GitHub Integration**: Full support for GitHub Actions, SSH integration, and secrets management.


## Quick Start Guide

Github Authentication:

In your host system

Run the [DevContainer]() in VS Code to get started with VSKit. The DevContainer provides a pre-configured environment with all the tools you need to start developing containerized applications. You can then use the integrated GitHub Actions to automate your CI/CD pipelines and deploy your containers to the cloud.

## How It Works

VSKit simplifies container development by integrating:

- **Dev Containers**: Pre-configured container environments for VS Code.
- **GitHub Actions**: Automate builds, tests, and deployments using GitHub CI/CD.
- **GitHub Container Registry**: Manage container images directly from GitHub Packages.

## Features

- [VS Code](https://code.visualstudio.com/): Development environment.
- [Makefile](https://www.gnu.org/software/make/): Project automation and task management.

### Local Development

Dev Containers

- [DevContainer](https://code.visualstudio.com/docs/remote/containers): Pre-configured container environments for VS Code.
  - [Ubuntu 22](https://hub.docker.com/_/ubuntu): Base image for development.
  - [Microsoft Artifact Registry](https://mcr.microsoft.com/en-us/)

Quality

- [Trunk.io](https://trunk.io/): Code quality and security analysis.
- [ActionLint]()
- [CodeQL](https://securitylab.github.com/tools/codeql): Code quality and security analysis.
- [Prettier](https://prettier.io/): Code formatting.
- [ShellCheck](https://www.shellcheck.net/): Shell script analysis.
- [YAML Lint](https://yamllint.readthedocs.io/en/stable/): YAML linting.


### Configuration

Environment Variables

- [DotEnvX](https://dotenvx.com/): Manage environment variables.
- [GitHub Actions Variables](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/store-information-in-variables): Secure secrets management.

Secrets Management

- [Doppler](https://doppler.com/): Secure secrets management.
- [Vault](https://www.hashicorp.com/products/vault): Secure secret management.
- [GitHub Actions Secrets](https://docs.github.com/en/actions/reference/encrypted-secrets): Secure secrets management.

### GitHub

> GitHub is the primary platform targetted for all Skymodules.io projects.

### GitHub Actions


### 1. Codebase

One codebase tracked in GitHub:

- **[GitHub](https://github.com)**: Centralized version control and development platform.

### 2. Dependencies

Declare and isolate dependencies:

- **[Docker](https://docker.com)**: Build, ship, and run containerized applications.
- **[OCI](https://opencontainers.org/)**: Open Container Initiative standards.

### 3. Configuration

Configuration through environment variables:

- **[DotEnvX](https://dotenvx.com/)**: Manage environment variables.
  - **[GitHub Actions](https://dotenvx.com/docs/cis/github-actions)

- **[Vault](https://www.hashicorp.com/products/vault)**: Secure secret management.
  - **[GitHub Actions](https://github.com/hashicorp/vault-action)**

### 4. Backing Services

Integrate with cloud services:

### 5. Build, Release, Run

Automated build and run stages:

- **GitHub Actions**: CI/CD for seamless automation.

### 6. Processes

Run processes as stateless containers:

- **GitHub Actions** for process execution.

### 7. Port Binding

Bind apps to ports:

- HTTP Proxy and Network Load Balancer for containerized applications.

### 8. Concurrency

Horizontal scaling by adding processes:

- **Auto-Scaling**: Dynamic scaling based on demand.
- **Horizontal Provisioning**: Add resources as needed.

### 9. Disposability

Processes as disposable entities:

- Orchestrate and manage container lifecycle efficiently.

### 10. Dev/Prod Parity

Maintain consistent environments:

- **Infrastructure as Code (IaC)** using **Terraform** for environment consistency.

### 11. Logs

Stream logs as event streams:

- **Loki** and **Vector** for log aggregation and observability.

### 12. Admin Processes

Run admin tasks as one-off processes:

- **Runbook Automation**: Automate operational tasks.

## Standards & Compliance

- **[OCI](https://opencontainers.org/)**: Open Container Initiative standards.
- **[Vector](https://vector.dev/)**: High-performance event and log aggregation.

## License

VSKit is licensed under the [MIT License](LICENSE).

---

This Starter-Kit will be used to create others via forks.

## Additional Kits

- [Azure-VS-Kit]()
- [AWS-VS-Kit]()
- [GCP-VS-Kit]()
- [IBM-VS-Kit]()
- [Oracle-VS-Kit]()
- [Tencent-VS-Kit]()
- [Alibaba-VS-Kit]()