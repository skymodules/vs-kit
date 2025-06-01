export WORKSPACE=$(shell pwd)
export DEVCONTAINER=$(WORKSPACE)/.devcontainer

# Config/Environment control
SDLC_ENVIRONMENT ?= pr
ENV_FILE = ./env/.env
SDLC_ENV_FILE = ./env/.env.$(SDLC_ENVIRONMENT)
XFILES = ~/.env $(ENV_FILE) $(SDLC_ENV_FILE)

include $(XFILES)

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
	@echo "🪐 APPLICATION_NAME: $(APPLICATION_NAME)"
	@echo "🦖 GIT COMMIT: $(GIT_COMMIT)"
	@echo "🦖 GIT BRANCH: $(GIT_BRANCH)"
	@echo "🦖 Git User Name: $(shell git config user.name)"
	@echo "🦖 Git User Email: $(shell git config user.email)"
	@echo "Doppler Project: $(DOPPLER_PROJECT)"
	@echo "🐳 CONTAINER_NAME: $(CONTAINER_NAME)"
	@echo "🐳 IMAGE_NAME: $(IMAGE_NAME)"
	@echo "🐳 TAG: $(TAG)"


.PHONY: devcontainer
# build the devcontainer and veriyf the container works
devcontainer:
	@dotenvx run --quiet -f $(XFILES) -- devcontainer build \
		--workspace-folder "."
	echo "🐳 Devcontainer built"

.PHONY: devcontainer/test
# run tests inside the devcontainer
devcontainer/test: devcontainer
	dotenvx run --quiet -f $(XFILES) -- devcontainer exec \
		--workspace-folder "." \
		--container-id "$(CONTAINER_NAME)" \
		--cmd "npm"

# combines linting, security, and secrets checks
check:
	@dotenvx run --quiet -f $(XFILES) -- trunk check --fix


.PHONY: build
# build the docker image
build:
	@dotenvx run --quiet -f $(XFILES) -- docker build \
		--build-arg GIT_COMMIT=$(GIT_COMMIT) \
		--build-arg GIT_BRANCH=$(GIT_BRANCH) \
		--build-arg SDLC_ENVIRONMENT=$(SDLC_ENVIRONMENT) \
		-t $(IMAGE_NAME) \
		-f ./Dockerfile ./
	@echo "🐳 Image built: $(IMAGE_NAME)"
	@docker images --tree

.PHONY: run
# run the docker image and nodeJS application
run:
	@dotenvx run -f $(XFILES) -- doppler run -p $(DOPPLER_PROJECT) -c $(DOPPLER_CONFIG) -- npm run start
	@echo "🐳 Container running: $(CONTAINER_NAME)"

.PHONY: test
# run tests
test:
	@dotenvx run --quiet -f $(XFILES) -- npm run test

.PHONY: publish
# publish the docker image to the registry
publish:
	@dotenvx run --quiet -f $(XFILES) -- docker tag $(IMAGE_NAME) $(REGISTRY)
	@dotenvx run --quiet -f $(XFILES) -- docker push $(REGISTRY)
	@echo "🐳 Image published: $(REGISTRY)"


.PHONY: dev
# run the locally
dev:
	@rm -rf ./dist/
	@dotenvx run --quiet -f $(XFILES) -- doppler run -p $(PROJECT_NAME) -c "gh" --command="npm run watch"
