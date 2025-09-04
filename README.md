# VS Kit

## Features 

- [VS Code Dev Container](./.devcontainer/devcontainer.json)
- [Doppler Secrets Management](https://www.doppler.com/)
- [Dotenvx Environment Management](https://github.com/evilmartians/dotenvx)
- [GitHub Copilot Custom Instructions](https://docs.github.com/en/copilot/how-tos/configure-custom-instructions/add-repository-instructions?tool=vscode)
- [Makefile for common tasks](./Makefile)
- Automated SSH Key Generation and Management with GitHub Secrets and Doppler
- [Trunk for code quality](https://trunk.io/)


## Host Setup 

The host machine is your development machine, that will run the devcontainer for this project. It will reference a local ~/.env file for your `DOPPLER_TOKEN` environment variable. The Devcontainer will use this token to authenticate with Doppler to fetch the other secrets.

## Github Setup (CI/CD Platform for this project)

The following need to be setup in GitHub:

- A GitHub organization (or use your personal account)
- A GitHub Token with repo access for the repository

## Doppler Setup

The following needs to be setup in Doppler:

- A Doppler Project
- A Doppler Config (e.g. pr, test, live)
- A Service Token with access to the Project and Config
- The following secrets in Doppler:
    - `GITHUB_TOKEN` - a GitHub token with repo access for the repository
    - (Any other secrets your application needs)


## Makefile

The Makefile contains common tasks for the project. It uses `dotenvx` and `doppler` to manage environment variables and secrets.

To check your project's settings run:

```bash
make 
```
this will show you the current settings for the project.

```bash
🪐 PROJECT_NAME: vs-kit
🪐 SDLC ENVIRONMENT: pr
🪐 APPLICATION_NAME: devcontainer
🦖 GIT COMMIT: 
🦖 GIT BRANCH: 
🦖 Git User Name: SkyModules
🦖 Git User Email: rex@skymodules.io
Doppler Project: devcontainers
🐳 CONTAINER_NAME: vs-kit-devcontainer
🐳 IMAGE_NAME: vs-kit-devcontainer:v1.0
🐳 TAG: v1.0
```


## References 

**GitHub CoPilot** 

- [Add repository instructions](https://docs.github.com/en/copilot/how-tos/configure-custom-instructions/add-repository-instructions?tool=vscode)
