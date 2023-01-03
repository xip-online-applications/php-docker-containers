SHELL := /bin/bash
.PHONY: build for-version

build:
	$(MAKE) build-build
	$(MAKE) build-fpm

build-%:
	cd $* ; $(MAKE) build RELEASE=$(RELEASE) REPO_BASE=$(REPO)
