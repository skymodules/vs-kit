ARG TAG="dev-3.12-bookworm"
ARG IMAGE="mcr.microsoft.com/devcontainers/python"

FROM ${IMAGE}:${TAG}

USER root
RUN mkdir -p "/home/vscode/tempx/"
COPY install.sh /home/vscode/install.sh
RUN ls -l /home/vscode/ && chmod +x /home/vscode/install.sh

COPY install-hashicorp.sh /home/vscode/install-hashicorp.sh
RUN ls -l /home/vscode/ && chmod +x /home/vscode/install-hashicorp.sh

COPY shell.sh /home/vscode/shell.sh
RUN ls -l /home/vscode/ && chmod +x /home/vscode/shell.sh
RUN chown vscode:vscode /usr/local/bin

# User
USER vscode

WORKDIR /workspace
RUN mkdir -p /workspace/temp

WORKDIR /workspace/temp
RUN /home/vscode/install.sh
RUN trunk --version

RUN /home/vscode/install-hashicorp.sh vault
RUN vault --version

CMD ["dotenvx", "run", "--", "node", "index.js"]
