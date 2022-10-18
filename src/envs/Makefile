SHELL := /bin/bash
.PHONY: build for-version

REPO_BASE := $(REPO)-extra

build:
	cd dev ; make build RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd prod ; make build RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)

for-version:
	cd dev ; make for-version VERSION=$(VERSION) RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd prod ; make for-version VERSION=$(VERSION) RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
