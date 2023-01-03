SHELL := /bin/bash
.PHONY: build for-version

REPO_BASE := $(REPO)-extra

build: dev prod
	echo "Done building environments."

dev:
	cd dev ; make build RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)

prod:
	cd prod ; make build RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)
