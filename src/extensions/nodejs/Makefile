SHELL := /bin/bash
.PHONY: build for-version

REPO_EXT := $(REPO_BASE)-nodejs
RELEASE_TAG := $(VERSION).$(RELEASE)
RELEASE_TAG_SHORT := $(VERSION)

build: build-14 build-16 build-18 build-19
	echo "Done build."

build-%:
	$(MAKE) for-version VERSION=$* RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)

for-version:
	docker buildx build --cache-from type=gha --cache-to type=gha,mode=max --platform linux/amd64,linux/arm64 --pull --tag $(REPO_EXT):$(RELEASE_TAG) --build-arg NODEJS_VERSION=$(VERSION) --push .
	docker buildx imagetools create --tag $(REPO_EXT):$(RELEASE_TAG_SHORT) $(REPO_EXT):$(RELEASE_TAG)
