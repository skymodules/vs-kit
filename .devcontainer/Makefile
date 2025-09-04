.PHONY: devcontainer/build
# build the devcontainer and veriyf the container works
devcontainer/build:
	$(call envrun,$(call doprun,devcontainer build --workspace-folder "."))
	echo "🐳 Devcontainer built"

.PHONY: devcontainer/run
# run the devcontainer
devcontainer/run: devcontainer/build
	$(call envrun,$(call doprun,devcontainer up --workspace-folder "." --container-id "$(CONTAINER_NAME)" --force-rebuild))
	$(call envrun,$(call doprun,devcontainer exec --workspace-folder "." --container-id "$(CONTAINER_NAME)" --cmd "gh auth status || echo 'not authenticated'"))

.PHONY: devcontainer/test
# run tests inside the devcontainer
devcontainer/test: devcontainer/run
	$(call envrun,$(call doprun,devcontainer exec --workspace-folder "." --container-id "$(CONTAINER_NAME)" --cmd "npm run test"))
	$(call envrun,$(call doprun,devcontainer exec --workspace-folder "." --container-id "$(CONTAINER_NAME)" --cmd "gh auth status || echo 'not authenticated'"))
