# SkyModules Dev Container

## Host Machine Setup Instructions

Install the DevContainer build tool:

```bash
npm install -g @devcontainers/cli
```

Verify you can run it:

```bash
devcontainer <command>

Commands:
  devcontainer up                   Create and run dev container
  devcontainer build [path]         Build a dev container image
  devcontainer run-user-commands    Run user commands
  devcontainer read-configuration   Read configuration
  devcontainer features             Features commands
  devcontainer templates            Templates commands
  devcontainer exec <cmd> [args..]  Execute a command on a running dev container

Options:
  --help     Show help                                                 [boolean]
  --version  Show version number                                       [boolean]
```

The Makefil in the root of the project contains a target to build the dev container:

```bash
make devcontainer
```