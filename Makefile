export WORKSPACE=$(shell pwd)
export DEVCONTAINER=$(WORKSPACE)/.devcontainer

# Config/Environment control
ENVIRONMENT ?= pr
ENV_FILE = ./env/.env.$(ENVIRONMENT)
ENV_VARS := $(shell dotenvx get --format shell -f $(ENV_FILE))

# Load environment variables from the specified file
ifneq ("$(wildcard $(ENV_FILE))","")
    include $(ENV_FILE)
    export $(shell sed -e 's/=.*//' $(ENV_FILE))
else
    $(error Environment file $(ENV_FILE) not found)
endif

# git config
GIT_COMMIT := $(shell git rev-parse HEAD || echo "unknown")
GIT_BRANCH := $(shell git rev-parse --abbrev-ref HEAD || echo "unknown")

# container config
TAG := v1.0
CONTAINER_NAME := $(PROJECT_NAME)$(APPLICATION_NAME)
IMAGE_NAME := $(CONTAINER_NAME):$(TAG)
REGISTRY := $(REGISTRY_URL)/$(IMAGE_NAME)
CURRENT_DIR := $(shell pwd)

.PHONY: default
# list all of the parameters and current context
default:
	@echo "🪐 PROJECT_NAME: $(PROJECT_NAME)"
	@echo "🪐 SDLC ENVIRONMENT: $(SDLC_ENVIRONMENT)"
	@echo "🪐 SERVICE_NAME: $(SERVICE_NAME)"
	@echo "🦖 GIT COMMIT: $(GIT_COMMIT)"
	@echo "🦖 GIT BRANCH: $(GIT_BRANCH)"
	@echo "🐳 CONTAINER_NAME: $(CONTAINER_NAME)"
	@echo "🐳 IMAGE_NAME: $(IMAGE_NAME)"
	@echo "🐳 TAG: $(TAG)"

.PHONY: check
# combines linting, security, and secrets checks
check:
	dotenvx run --quiet -f ./env/.env.local -- trunk check --fix