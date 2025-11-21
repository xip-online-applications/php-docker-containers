include $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/../../common.Makefile

.PHONY: build build-% for-version

REPO_EXT := $(REPO_BASE)-$(notdir $(CURDIR))

RELEASE_TAG := $(VERSION).$(RELEASE)
RELEASE_TAG_SHORT := $(VERSION)

BUILD_PREREQS ?= build-8.1 build-8.2 build-8.3 build-8.4 build-8.5

build: $(BUILD_PREREQS)
	echo "Done build."

build-%:
	$(MAKE) for-version VERSION=$* RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)

for-version:
	docker buildx build --cache-from type=registry,ref=$(REPO_EXT):cache --cache-to type=registry,ref=$(REPO_EXT):cache,mode=max --platform linux/amd64,linux/arm64 --pull --tag $(REPO_EXT):$(RELEASE_TAG) --build-arg REPO=$(REPO) --build-arg PHP_VERSION=$(RELEASE_TAG) --push .
	docker buildx imagetools create --tag $(REPO_EXT):$(RELEASE_TAG_SHORT) $(REPO_EXT):$(RELEASE_TAG)
