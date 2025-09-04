#!/usr/bin/env bash

install_nvm(){
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
}

install_npm(){
    nvm install 22 && nvm use 22
}

# These are things you need on your host system in order to use this dev container
install_dev_container_cli(){
    npm install -g @devcontainers/cli
}


main(){
    echo "Setting up your host tooling..."

    install_nvm || {
        echo "Failed to install npm"
        exit 1
    }

    install_npm || {
        echo "Failed to install npm"
        exit 1
    }

    install_dev_container_cli || {
        echo "Failed to install devcontainer CLI"
        exit 1
    }

    echo "Host setup complete."
}

main "$@" 