SHELL := /bin/bash
.PHONY: build for-version

REPO_EXT := $(REPO_BASE)-mbstring
RELEASE_TAG := $(VERSION).$(RELEASE)
RELEASE_TAG_SHORT := $(VERSION)

build: build-7.4 build-8.0 build-8.1
	echo "Done build."

build-%:
	$(MAKE) for-version VERSION=$* RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)

for-version:
	docker buildx build --cache-from type=gha --cache-to type=gha,mode=max --platform linux/amd64,linux/arm64 --pull --tag $(REPO_EXT):$(RELEASE_TAG) --build-arg REPO=$(REPO) --build-arg PHP_VERSION=$(RELEASE_TAG) --push .
	docker buildx imagetools create --tag $(REPO_EXT):$(RELEASE_TAG_SHORT) $(REPO_EXT):$(RELEASE_TAG)
