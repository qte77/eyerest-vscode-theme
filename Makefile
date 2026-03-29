.SILENT:
.ONESHELL:
.PHONY: help package install clean png vsix-readme
.DEFAULT_GOAL := help

VSIX_DIR := vsix
VERSION := $(shell node -p "require('./package.json').version")
VSIX_NAME := eyerest-vscode-theme-$(VERSION).vsix
VSIX_PATH := $(VSIX_DIR)/$(VSIX_NAME)
VSIX_README := $(VSIX_DIR)/README.vsix.md


# MARK: PACKAGE


png:  ## Convert screenshot SVGs to PNGs (requires librsvg2-bin)
	if ! command -v rsvg-convert > /dev/null 2>&1; then \
		sudo apt-get install -y librsvg2-bin; fi
	for svg in assets/screenshots/eyerest-*-screenshot.svg; do \
		case "$$svg" in *-dark-*|*-light-*) \
			rsvg-convert -w 1800 "$$svg" -o "$${svg%.svg}.png" ;; esac; \
	done

vsix-readme: | $(VSIX_DIR)  ## Generate SVG-free README for vsix (uses PNGs)
	awk '\
	/<details>/{next} \
	/<\/details>/{next} \
	/<summary>/{gsub(/.*<summary>/,"### ");gsub(/<\/summary>/,"");print;print"";next} \
	/<img alt=/{split($$0,a,"\"");alt=a[2];next} \
	/src=/{gsub(/.*src="/,"https://raw.githubusercontent.com/qte77/eyerest-vscode-theme/main/");gsub(/-screenshot\.svg"/,"-dark-screenshot.png");printf "![%s](%s)\n\n",alt,$$0;next} \
	/width="100%"/{next} \
	{print}' README.md > $(VSIX_README)

package: vsix-readme  ## Build .vsix package into vsix/
	if ! command -v vsce > /dev/null 2>&1; then npm install -g @vscode/vsce; fi
	vsce package --readme-path $(VSIX_README) --allow-missing-repository -o $(VSIX_PATH)

install: package  ## Install .vsix locally (builds first if needed)
	code --install-extension $(VSIX_PATH)

clean:  ## Remove vsix/ build artifacts
	rm -rf $(VSIX_DIR)

$(VSIX_DIR):
	mkdir -p $(VSIX_DIR)


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
