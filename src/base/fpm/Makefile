SHELL := /bin/bash
.PHONY: build for-version manifest manifest-version

include $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/../../../arch.Makefile

REPO := $(REPO_BASE)
REPO_BUILD := $(REPO_BASE)-build
RELEASE_TAG := $(VERSION).$(RELEASE)
RELEASE_TAG_SHORT := $(VERSION)
BASE_DOCKERFILE := $(if $(wildcard $(VERSION)/manual.Dockerfile),$(VERSION)/manual.Dockerfile,$(VERSION)/Dockerfile)

build: for-version-8.2 for-version-8.3 for-version-8.4 for-version-8.5
	echo "Done building FPM images."

manifest: manifest-version-8.2 manifest-version-8.3 manifest-version-8.4 manifest-version-8.5
	echo "Done joining FPM images."

for-version-%:
	$(MAKE) for-version VERSION=$* RELEASE=$(RELEASE)

manifest-version-%:
	$(MAKE) manifest-version VERSION=$* RELEASE=$(RELEASE)

for-version:
	docker buildx build --cache-from type=registry,ref=$(REPO_BUILD):$(VERSION)-fpm-cache$(ARCH_SUFFIX) --cache-to type=registry,ref=$(REPO_BUILD):$(VERSION)-fpm-cache$(ARCH_SUFFIX),mode=min --platform $(PLATFORMS) --tag $(REPO_BUILD):$(RELEASE_TAG)-fpm$(ARCH_SUFFIX) --file $(BASE_DOCKERFILE) --push .
	docker buildx build --cache-from type=registry,ref=$(REPO):$(VERSION)-fpm-cache$(ARCH_SUFFIX) --cache-to type=registry,ref=$(REPO):$(VERSION)-fpm-cache$(ARCH_SUFFIX),mode=min --platform $(PLATFORMS) --tag $(REPO):$(RELEASE_TAG)-fpm$(ARCH_SUFFIX) --file fpm.Dockerfile --build-arg REPO=$(REPO) --build-arg REPO_BUILD=$(REPO_BUILD) --build-arg RELEASE_TAG=$(RELEASE_TAG) --build-arg ARCH_SUFFIX=$(ARCH_SUFFIX) --push .
	$(if $(ARCH),,docker buildx imagetools create --tag $(REPO):$(RELEASE_TAG_SHORT)-fpm $(REPO):$(RELEASE_TAG)-fpm)

manifest-version:
	$(call join-arches,$(REPO_BUILD),$(RELEASE_TAG)-fpm)
	$(call join-arches,$(REPO),$(RELEASE_TAG)-fpm)
	docker buildx imagetools create --tag $(REPO):$(RELEASE_TAG_SHORT)-fpm $(REPO):$(RELEASE_TAG)-fpm
