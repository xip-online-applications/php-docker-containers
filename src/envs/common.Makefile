include $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/../../common.Makefile

.PHONY: build build-% for-version manifest manifest-version

REPO_EXT := $(REPO_BASE)-$(notdir $(CURDIR))

RELEASE_TAG := $(VERSION).$(RELEASE)
RELEASE_TAG_SHORT := $(VERSION)

BUILD_PREREQS ?= build-8.2 build-8.3 build-8.4 build-8.5

build: $(BUILD_PREREQS)
	echo "Done build."

manifest: $(BUILD_PREREQS:build-%=manifest-%)
	echo "Done joining."

build-%:
	$(MAKE) for-version VERSION=$* RELEASE=$(RELEASE) REPO=$(REPO)

manifest-%:
	$(MAKE) manifest-version VERSION=$* RELEASE=$(RELEASE) REPO=$(REPO)

for-version:
	$(RETRY) docker buildx build --cache-from type=registry,ref=$(REPO_EXT):$(VERSION)-cache$(ARCH_SUFFIX) --cache-to type=registry,ref=$(REPO_EXT):$(VERSION)-cache$(ARCH_SUFFIX),mode=min --platform $(PLATFORMS) --pull --tag $(REPO_EXT):$(RELEASE_TAG)$(ARCH_SUFFIX) --build-arg REPO=$(REPO) --build-arg PHP_VERSION=$(RELEASE_TAG) --push .
	$(if $(ARCH),,$(RETRY) docker buildx imagetools create --tag $(REPO_EXT):$(RELEASE_TAG_SHORT) $(REPO_EXT):$(RELEASE_TAG))

manifest-version:
	$(call join-arches,$(REPO_EXT),$(RELEASE_TAG))
	$(RETRY) docker buildx imagetools create --tag $(REPO_EXT):$(RELEASE_TAG_SHORT) $(REPO_EXT):$(RELEASE_TAG)
