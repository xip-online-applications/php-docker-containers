SHELL := /bin/bash
.PHONY: all build for-version

REPO_EXT := $(REPO_BASE)-amqp
RELEASE_TAG := $(VERSION).$(RELEASE)
RELEASE_TAG_SHORT := $(VERSION)

build:
	make for-version VERSION=7.4 RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)
	make for-version VERSION=8.0 RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)
	make for-version VERSION=8.1 RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)

for-version:
	docker buildx build --cache-from type=gha --cache-to type=gha,mode=max --platform linux/amd64,linux/arm64 --pull --tag $(REPO_EXT):$(RELEASE_TAG) --build-arg REPO=$(REPO) --build-arg PHP_VERSION=$(RELEASE_TAG) --push .
	docker buildx imagetools create --tag $(REPO_EXT):$(RELEASE_TAG_SHORT) $(REPO_EXT):$(RELEASE_TAG)
