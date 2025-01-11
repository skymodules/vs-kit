# trunk-ignore-all(checkov/CKV_DOCKER_3)
FROM alpine:3.14

# Healthcheck
HEALTHCHECK --interval=5s --timeout=3s --retries=3 \
    CMD wget -q --spider http://localhost:8080/health || exit 1
