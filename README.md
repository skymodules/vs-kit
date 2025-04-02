# 😎 VSKit (Visual Studio Code Kit)

**VSKit** is an advanced, intelligent development kit designed for Visual Studio Code. It simplifies the creation of containerized solutions by automating the entire lifecycle— from local development to deployment. With VSKit, you can seamlessly manage your development environment, CI/CD pipelines, and container registry integration.

**Dev Environments-As-Code**

This kit uses [Dev Containers]() and has a complete automated local development experience. Running the Dev Container locally will provide automated setup of the stgack needed to run the project.

## 😎 Key Features

- **VS Code Dev Containers**: Streamlined setup for development within containers.
- **DotEnvX and Doppler.io**: Secure management of environment variables and secrets.
- **GitHub Integration**: Full support for GitHub Actions, SSH integration, and repository automation.
- **Containerized NodeJS**: Pre-configured NodeJS environment for seamless development.
- **Automated CI/CD**: Built-in GitHub Actions for continuous integration and deployment.
- **Open Telemetry**: Integrated DataDog for performance monitoring and observability.
- **Code Quality and Security**: Automated code analysis with Trunk.io and CodeQL.

## Setup Guide

**🛠️ SaaS Dependencies**

This kit uses the following SaaS dependencies. You will need to setup an account with each of them:

> For an automated pattern see [SaaS Kit]()

- [doppler](https://doppler.com/) - [Create an account and a Project](https://docs.doppler.com/docs/create-project) at Doppler.
- [GitHub](https://github.com) - This kit uses GitHub as the primary CI/CD platform. You will need to setup a GitHub account and create a repository for your project. This repository will use terraform to apply settings to the repository. See `.github/workflows/check.yml` for more details.
- [DataDog](https://www.datadoghq.com/) - This kit uses DataDog as the default collector/exporter for Opentelemetry. You will need to setup a DataDog account and create an API key. See the [DataDog](https://docs.datadoghq.com/agent/docker/?tab=hostagentv6) documentation for more details.

**Setup VS Code**:

- Setup [VS Code](https://code.visualstudio.com/)
  - [VS Code Extension: Dev Containers]() `ms-vscode-remote.remote-containers`
  - [VS Code Extension: Runme]() `stateful.runme`
  - [VS Code Extension: Doppler]() `doppler.doppler-vscode`

These are needed on your host machine.

```bash
code --install-extension doppler.doppler-vscode
code --install-extension stateful.runme
code --install-extension ms-vscode-remote.remote-containers
```

**Doppler Authentication**:

In your host machine, create a file called `~/.env` and add the following line:

```bash
DOPPLER_TOKEN=your_doppler_token
```

You can get your Doppler token from the [Doppler Dashboard](https://dashboard.doppler.com/). This is crucial for the Dev Container to access your Doppler secrets.

**Doppler GitHub Integration**:

- After creating your Doppler project, you need to integrate it with your GitHub organization. This will allow the Dev Container to access the secrets stored in Doppler.
- To do this, go to the [Doppler Dashboard](https://dashboard.doppler.com/) and navigate to your project. Click on the "Integrations" tab and select "GitHub". Follow the instructions to connect your Doppler project with your GitHub organization.
- Once the integration is complete, you will be able to see your Doppler project in the GitHub Actions Secrets. This will allow you to use the secrets stored in Doppler in your GitHub Actions workflows.

**Data Dog OpenTelemetry**:

- After creating your DataDog account, you need to create an API key. This key will be used to authenticate with DataDog and send telemetry data from the Dev Container. Store this in Doppler as `DATADOG_API_KEY`.
- Additionally, add this Open Telemetry secret to Doppler:

```sh
OTEL_EXPORTER_OTLP_LOGS_HEADERS="dd-protocol=otlp,dd-api-key=${DD_API_KEY}"
```

**Github Authentication**:

- After completing Doppler Setup, you should add your `GITHUB_TOKEN` to doppler in your Project. If Doppler is synced with your GitHub organization, then you can see the `GITHUB_TOKEN` in the GitHub Actions Secrets.
- The DevContainer will automatically use the `GITHUB_TOKEN` from Doppler to authenticate with GitHub on container start. This container will also automatically manage a GitHub SSH key for you. This key will be used to authenticate with GitHub when you push code from the container.

**Run the Dev Container**:

Run the [DevContainer](https://code.visualstudio.com/docs/devcontainers/containers) in VS Code to get started with [VS-Kit](https://github.com/skymodules/vs-kit). The DevContainer provides a pre-configured environment with all the tools you need to start developing containerized applications. You can then use the integrated [GitHub Actions](https://docs.github.com/en/actions) to automate your CI/CD pipelines and deploy your containers to the cloud.

## Development Guide

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

- **Tooling**
- Default tooling for the DevContainer:

  - [DotenvX](https://dotenvx.com/): Environment variable management.
  - [Doppler](https://doppler.com/): Secure secrets management.
  - [DataDog](https://www.datadoghq.com/): Monitoring and observability. (OpenTelemetry)

- **Containerizssed NodeJS Lifecycle**

  - [NodeJS](https://nodejs.org/): JavaScript runtime.
  - [NPM](https://www.npmjs.com/): Package manager for Node.js.
  - [Docker](https://www.docker.com/): Containerization platform.

### GitHub

> GitHub is the primary platform targetted for all Skymodules.io projects.

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
