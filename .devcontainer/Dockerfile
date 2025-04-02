ARG TAG="dev-3.12-bookworm"
ARG IMAGE="mcr.microsoft.com/devcontainers/python"
ARG VSCODE_USER="vscode"

FROM ${IMAGE}:${TAG}

USER root
RUN mkdir -p /home/${VSCODE_USER}/tempx/
COPY install.sh /home/${VSCODE_USER}/install.sh
RUN ls -l /home/${VSCODE_USER}/ && chmod +x /home/${VSCODE_USER}/install.sh

COPY install-hashicorp.sh /home/${VSCODE_USER}/install-hashicorp.sh
RUN ls -l /home/${VSCODE_USER}/ && chmod +x /home/${VSCODE_USER}/install-hashicorp.sh

COPY shell.sh /home/${VSCODE_USER}/shell.sh
RUN ls -l /home/${VSCODE_USER}/ && chmod +x /home/${VSCODE_USER}/shell.sh
RUN chown ${VSCODE_USER}:${VSCODE_USER} /usr/local/bin

# User
USER ${VSCODE_USER}

WORKDIR /workspace
RUN mkdir -p /workspace/temp

WORKDIR /workspace/temp
RUN /home/${VSCODE_USER}/install.sh
RUN trunk --version

RUN /home/${VSCODE_USER}/install-hashicorp.sh vault
RUN vault --version
RUN /home/${VSCODE_USER}/install-hashicorp.sh terraform
RUN terraform --version

