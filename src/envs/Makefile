SHELL := /bin/bash
.PHONY: build for-version

REPO_BASE := $(REPO)-extra

build: env-dev env-prod
	echo "Done building environments."

env-%:
	cd $* ; $(MAKE) build RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)
