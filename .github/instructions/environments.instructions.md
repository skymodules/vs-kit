## Environments

This project is configured to use the following modern SDLC environment configuration. 

Docs: [Types of Environments](https://skymodules.hashnode.space/default-guide/environment-model/types-of-environments)

**Setup**

The folder `./env` contains the various environment files.

**PR Environment**

🟨 `./env/pr.env` - This file is used for Pull Request (PR) environments. It contains environment variables that are specific to PRs, allowing for isolated testing and development.

🟧 `./env/test.env` - This file is used for testing environments. It contains environment variables that are specific to testing, allowing for isolated testing and development.

🟩🟦 `./env/live.env` - This file is used for live environments. It contains environment variables that are specific to live deployments, ensuring that the application runs with the correct configuration in production.

## Makefile

The `Makefile` in the root of hte respository contains a variable `SDLC_ENVIRONMENT` which can be used to specifyt the environment.

```bash
make <target> SDLC_ENVIRONMENT=<environment> 
```

