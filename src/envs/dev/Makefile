SHELL := /bin/bash
.PHONY: build for-version

REPO_EXT := $(REPO_BASE)-dev
RELEASE_TAG := $(VERSION).$(RELEASE)
RELEASE_TAG_SHORT := $(VERSION)

build:
	make for-version VERSION=7.4 RELEASE=$(RELEASE) REPO=$(REPO)
	make for-version VERSION=8.0 RELEASE=$(RELEASE) REPO=$(REPO)
	make for-version VERSION=8.1 RELEASE=$(RELEASE) REPO=$(REPO)

for-version:
	docker buildx build --cache-from type=gha --cache-to type=gha,mode=max --platform linux/amd64,linux/arm64 --pull --tag $(REPO_EXT):$(RELEASE_TAG) --build-arg REPO=$(REPO) --build-arg PHP_VERSION=$(RELEASE_TAG) --push .
	docker buildx imagetools create --tag $(REPO_EXT):$(RELEASE_TAG_SHORT) $(REPO_EXT):$(RELEASE_TAG)
