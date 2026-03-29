.SILENT:
.ONESHELL:
.PHONY: help package install clean
.DEFAULT_GOAL := help

VSIX_DIR := vsix
VSIX_NAME := eyerest-vscode-theme-0.1.0.vsix
VSIX_PATH := $(VSIX_DIR)/$(VSIX_NAME)


# MARK: PACKAGE


package: $(VSIX_PATH)  ## Build .vsix package into vsix/

$(VSIX_PATH):
	mkdir -p $(VSIX_DIR)
	if ! command -v vsce > /dev/null 2>&1; then npm install -g @vscode/vsce; fi
	vsce package --readme-path README.vsix.md --allow-missing-repository -o $(VSIX_PATH)

install: $(VSIX_PATH)  ## Install .vsix locally (builds first if needed)
	code --install-extension $(VSIX_PATH)

clean:  ## Remove vsix/ build artifacts
	rm -rf $(VSIX_DIR)


# MARK: HELP


help:  ## Show available recipes
	echo "Usage: make [recipe]"
	echo ""
	awk '/^# MARK:/ { \
		section = substr($$0, index($$0, ":")+2); \
		printf "\n\033[1m%s\033[0m\n", section \
	} \
	/^[a-zA-Z0-9_-]+:.*?##/ { \
		helpMessage = match($$0, /## (.*)/); \
		if (helpMessage) { \
			recipe = $$1; \
			sub(/:/, "", recipe); \
			printf "  \033[36m%-22s\033[0m %s\n", recipe, substr($$0, RSTART + 3, RLENGTH) \
		} \
	}' $(MAKEFILE_LIST)
