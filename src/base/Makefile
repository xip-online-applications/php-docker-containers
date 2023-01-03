SHELL := /bin/bash
.PHONY: build for-version

build:
	cd build ; $(MAKE) build RELEASE=$(RELEASE) REPO_BASE=$(REPO)
	cd fpm ; $(MAKE) build RELEASE=$(RELEASE) REPO_BASE=$(REPO)
