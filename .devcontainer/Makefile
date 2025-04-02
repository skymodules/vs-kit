.PHONY: dc/build
# build the devcontainer (dc)
dc/build:
	@devcontainer build --workspace-folder "./$(DEVCONTAINER)" --config "./$(DEVCONTAINER)/devcontainer.json" --log-level info --image-name $(IMAGE_NAME)
