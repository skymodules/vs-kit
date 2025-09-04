export WORKSPACE=$(shell pwd)
export DEVCONTAINER=$(WORKSPACE)/.devcontainer

# Config/Environment control
SDLC_ENVIRONMENT ?= pr
SYSTEM_ENV_FILE = ~/.env
PROJECT_ENV_FILE = ./env/.env
SDLC_ENV_FILE = ./env/$(SDLC_ENVIRONMENT).env
ENV_FILES = ~/.env  $(SYSTEM_ENV_FILE) $(PROJECT_ENV_FILE) $(SDLC_ENV_FILE)

include $(ENV_FILES)

# git config
GIT_COMMIT := $(shell git rev-parse  >> /dev/null || echo "unknown")
GIT_BRANCH := $(shell git rev-parse --abbrev-ref >> /dev/null || echo "unknown")

# container config
TAG := v1.0
CONTAINER_NAME := $(PROJECT_NAME)$(APPLICATION_NAME)
IMAGE_NAME := $(CONTAINER_NAME):$(TAG)
REGISTRY := $(REGISTRY_URL)/$(IMAGE_NAME)
CURRENT_DIR := $(shell pwd)

define envrun
    dotenvx run --quiet -f $(ENV_FILES) -- $(1)
endef

define doprun
    doppler run -p $(PROJECT_NAME) -c $(DOPPLER_CONFIG) -- $(1)
endef

.PHONY: default
# list all of the parameters and current context
default:
	@echo "🪐 PROJECT_NAME: $(PROJECT_NAME)"
	@echo "🪐 SDLC ENVIRONMENT: $(SDLC_ENVIRONMENT)"
	@echo "🪐 APPLICATION_NAME: $(APPLICATION_NAME)"
	@echo "🦖 GIT COMMIT: $(GIT_COMMIT)"
	@echo "🦖 GIT BRANCH: $(GIT_BRANCH)"
	@echo "🦖 Git User Name: $(shell git config user.name || echo 🈵)"
	@echo "🦖 Git User Email: $(shell git config user.email || echo 🈵)"
	@echo "Doppler Project: $(DOPPLER_PROJECT)"
	@echo "🐳 CONTAINER_NAME: $(CONTAINER_NAME)"
	@echo "🐳 IMAGE_NAME: $(IMAGE_NAME)"
	@echo "🐳 TAG: $(TAG)"

include ./.devcontainer/Makefile

.PHONY: check
# combines linting, security, and secrets checks
check:
	$(call envrun,$(call doprun, npm run lint))
	$(call envrun,$(call doprun, npm run security))
	$(call envrun,$(call doprun, trunk check --fix))

.PHONY: build
# build the docker image
build:
	$(call envrun,$(call doprun,docker build \
		--build-arg GIT_COMMIT=$(GIT_COMMIT) \
		--build-arg GIT_BRANCH=$(GIT_BRANCH) \
		--build-arg SDLC_ENVIRONMENT=$(SDLC_ENVIRONMENT) \
		-t $(IMAGE_NAME) \
		-f ./Dockerfile ./))
	@echo "🐳 Image built: $(IMAGE_NAME)"
	@docker images --tree

.PHONY: run
# run the docker image and nodeJS application
run:
	$(call envrun,$(call doprun,npm run start))
	@echo "🐳 Container running: $(CONTAINER_NAME)"

.PHONY: test
# run tests
test:
	$(call envrun,$(call doprun,npm run test))

.PHONY: publish
# publish the docker image to the registry
publish:
	$(call envrun,$(call doprun,docker tag $(IMAGE_NAME) $(REGISTRY)))
	$(call envrun,$(call doprun,docker push $(REGISTRY)))
	@echo "🐳 Image published: $(REGISTRY)"


.PHONY: dev
# run the locally
dev:
	@rm -rf ./dist/
	$(call envrun,$(call doprun,npm run dev))
