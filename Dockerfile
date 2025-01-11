# trunk-ignore-all(checkov/CKV_DOCKER_3)
FROM alpine:3.14

# install otel
RUN curl --proto '=https' --tlsv1.2 -fOL https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/v0.117.0/otelcol_0.117.0_linux_amd64.tar.gz

# extract otel
# trunk-ignore(hadolint/DL3059)
RUN tar -xvf otelcol_0.117.0_linux_amd64.tar.gz

# copy source pattern
RUN mkdir /app
WORKDIR /app
COPY src/ .

# Install dependencies
#

# Run the application
#

# Healthcheck
HEALTHCHECK --interval=5s --timeout=3s --retries=3 \
    CMD wget -q --spider http://localhost:8080/health || exit 1
