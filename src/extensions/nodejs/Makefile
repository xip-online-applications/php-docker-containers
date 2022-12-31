SHELL := /bin/bash
.PHONY: all build for-version

REPO_EXT := $(REPO_BASE)-nodejs
RELEASE_TAG := $(VERSION).$(RELEASE)
RELEASE_TAG_SHORT := $(VERSION)

build:
	make for-version VERSION=14 RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	make for-version VERSION=16 RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	make for-version VERSION=18 RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	make for-version VERSION=19 RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)

for-version:
	docker buildx build --cache-from type=gha --cache-to type=gha,mode=max --platform linux/amd64,linux/arm64 --pull --tag $(REPO_EXT):$(RELEASE_TAG) --build-arg NODEJS_VERSION=$(VERSION) --push .
	docker buildx imagetools create --tag $(REPO_EXT):$(RELEASE_TAG_SHORT) $(REPO_EXT):$(RELEASE_TAG)
