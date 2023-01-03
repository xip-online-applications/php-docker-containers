SHELL := /bin/bash
.PHONY: prepare docker-login all base extensions release

RELEASE ?= "x-latest"
REPO ?= ghcr.io/xip-online-applications/php-docker-containers/php-dev

prepare:
	sudo apt-get update && sudo apt-get install -y qemu-user-static binfmt-support make
	docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
	docker buildx create --platform "linux/amd64,linux/arm64" --use

docker-login:
	echo ${GITHUB_TOKEN} | docker login ghcr.io -u ${GITHUB_USER} --password-stdin

all:
	make base RELEASE=$(RELEASE) REPO=$(REPO)
	make extensions RELEASE=$(RELEASE) REPO=$(REPO)

base: # Build the custom extensions
	cd src/base ; make -j 4 build RELEASE=$(RELEASE) REPO=$(REPO)

extensions: # Build the custom extensions
	cd src/extensions ; make -j 4 build RELEASE=$(RELEASE) REPO=$(REPO)
	cd src/envs ; make -j 4 build RELEASE=$(RELEASE) REPO=$(REPO)

release: # Build a release version
	make all RELEASE=$(RELEASE) REPO=ghcr.io/xip-online-applications/php-docker-containers/php

release-base: # Build a release version for the base containers
	make base RELEASE=$(RELEASE) REPO=ghcr.io/xip-online-applications/php-docker-containers/php

release-extensions: # Build a release version for the extensions
	make extensions RELEASE=$(RELEASE) REPO=ghcr.io/xip-online-applications/php-docker-containers/php
