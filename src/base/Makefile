SHELL := /bin/bash
.PHONY: build for-version

build:
	cd build ; make build RELEASE=$(RELEASE) REPO_BASE=$(REPO)
	cd fpm ; make build RELEASE=$(RELEASE) REPO_BASE=$(REPO)

for-version:
	cd build ; make for-version VERSION=$(VERSION) RELEASE=$(RELEASE) REPO_BASE=$(REPO)
	cd fpm ; make for-version VERSION=$(VERSION) RELEASE=$(RELEASE) REPO_BASE=$(REPO)
