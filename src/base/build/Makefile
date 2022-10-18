SHELL := /bin/bash
.PHONY: build for-version

REPO := $(REPO_BASE)
REPO_BUILD := $(REPO_BASE)-build
RELEASE_TAG := $(VERSION).$(RELEASE)
RELEASE_TAG_SHORT := $(VERSION)

build:
	make for-version VERSION=7.4 RELEASE=$(RELEASE)
	make for-version VERSION=8.0 RELEASE=$(RELEASE)
	make for-version VERSION=8.1 RELEASE=$(RELEASE)

for-version:
	docker buildx build --platform linux/amd64,linux/arm64 --tag $(REPO_BUILD):$(RELEASE_TAG) --file $(VERSION).Dockerfile --push .
	docker buildx build --platform linux/amd64,linux/arm64 --tag $(REPO):$(RELEASE_TAG) --file php.Dockerfile --build-arg RELEASE_TAG=$(RELEASE_TAG) --push .
	docker buildx imagetools create --tag $(REPO):$(RELEASE_TAG_SHORT) $(REPO):$(RELEASE_TAG)
