SHELL := /bin/bash
.PHONY: build for-version

build:
	cd build ; make -j 4 build RELEASE=$(RELEASE) REPO_BASE=$(REPO)
	cd fpm ; make -j 4 build RELEASE=$(RELEASE) REPO_BASE=$(REPO)
