ARG TAG="dev-22"
ARG IMAGE="mcr.microsoft.com/devcontainers/typescript-node"
ARG VSCODE_USER="vscode"

FROM ${IMAGE}:${TAG}

# dynamic build args
ARG VSCODE_USER
ENV LANG="C.UTF-8"

USER root

# Make sure the vscode user has access to /usr/local/bin
RUN chown -R ${VSCODE_USER}:${VSCODE_USER} /usr/local/bin
COPY ./ssh.sh /home/${VSCODE_USER}/ssh.sh

# Given that trunk is installed
# Then the ${VSCODE_USER} user should have access to run it
RUN sudo curl https://get.trunk.io -fsSL | bash && \
    sudo chown -R "${VSCODE_USER}":"${VSCODE_USER}" /usr/local/bin/trunk && \
    trunk

# Given that dotenvx is installed
# Then the ${VSCODE_USER} user should have access to run it
RUN 	curl -sfS "https://dotenvx.sh" | sh && \
    sudo chown -R  "${VSCODE_USER}":"${VSCODE_USER}" /usr/local/bin/dotenvx

# Given that doppler is installed
# Then the ${VSCODE_USER} user should have access to run it
RUN wget -t 3 -qO- https://cli.doppler.com/install.sh | sudo sh
