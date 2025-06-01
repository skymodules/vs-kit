ARG TAG="dev-22"
ARG IMAGE="mcr.microsoft.com/devcontainers/typescript-node"
ARG VSCODE_USER="vscode"

FROM ${IMAGE}:${TAG}

# dynamic build args
ARG VSCODE_USER


USER root

# trunk-ignore(hadolint/DL4006)
RUN curl -fsS https://dotenvx.sh | sh
RUN (curl -Ls --tlsv1.2 --proto "=https" --retry 3 https://cli.doppler.com/install.sh || wget -t 3 -qO- https://cli.doppler.com/install.sh) | sudo sh

COPY ssh.sh /home/${VSCODE_USER}/ssh.sh
RUN ls -l /home/${VSCODE_USER}/ && chmod +x /home/${VSCODE_USER}/ssh.sh


# User
USER ${VSCODE_USER}
WORKDIR /workspace
RUN mkdir -p /workspace/temp
RUN dotenvx --version
RUN doppler --version


HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD trunk --version && \
    doppler --version && \
    dotenvx --version && \
    vault --version && \
    terraform --version || exit 1
