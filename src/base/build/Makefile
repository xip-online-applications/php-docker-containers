SHELL := /bin/bash
.PHONY: build for-version manifest manifest-version

include $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/../../../arch.Makefile

REPO := $(REPO_BASE)
REPO_BUILD := $(REPO_BASE)-build
RELEASE_TAG := $(VERSION).$(RELEASE)
RELEASE_TAG_SHORT := $(VERSION)
BASE_DOCKERFILE := $(if $(wildcard $(VERSION)/manual.Dockerfile),$(VERSION)/manual.Dockerfile,$(VERSION)/Dockerfile)

build: for-version-8.2 for-version-8.3 for-version-8.4 for-version-8.5
	echo "Done building base images."

manifest: manifest-version-8.2 manifest-version-8.3 manifest-version-8.4 manifest-version-8.5
	echo "Done joining base images."

for-version-%:
	$(MAKE) for-version VERSION=$* RELEASE=$(RELEASE)

manifest-version-%:
	$(MAKE) manifest-version VERSION=$* RELEASE=$(RELEASE)

for-version:
	$(RETRY) docker buildx build --cache-from type=registry,ref=$(REPO_BUILD):$(VERSION)-cache$(ARCH_SUFFIX) --cache-to type=registry,ref=$(REPO_BUILD):$(VERSION)-cache$(ARCH_SUFFIX),mode=min --platform $(PLATFORMS) --tag $(REPO_BUILD):$(RELEASE_TAG)$(ARCH_SUFFIX) --file $(BASE_DOCKERFILE) --push .
	$(RETRY) docker buildx build --cache-from type=registry,ref=$(REPO):$(VERSION)-cache$(ARCH_SUFFIX) --cache-to type=registry,ref=$(REPO):$(VERSION)-cache$(ARCH_SUFFIX),mode=min --platform $(PLATFORMS) --tag $(REPO):$(RELEASE_TAG)$(ARCH_SUFFIX) --file php.Dockerfile --build-arg REPO_BUILD=$(REPO_BUILD) --build-arg RELEASE_TAG=$(RELEASE_TAG) --build-arg ARCH_SUFFIX=$(ARCH_SUFFIX) --push .
	$(if $(ARCH),,$(RETRY) docker buildx imagetools create --tag $(REPO):$(RELEASE_TAG_SHORT) $(REPO):$(RELEASE_TAG))

manifest-version:
	$(call join-arches,$(REPO_BUILD),$(RELEASE_TAG))
	$(call join-arches,$(REPO),$(RELEASE_TAG))
	$(RETRY) docker buildx imagetools create --tag $(REPO):$(RELEASE_TAG_SHORT) $(REPO):$(RELEASE_TAG)
