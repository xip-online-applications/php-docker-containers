SHELL := /bin/bash
.PHONY: all build for-version

REPO_EXT := $(REPO_BASE)-saxonc
RELEASE_TAG := $(VERSION).$(RELEASE)
RELEASE_TAG_SHORT := $(VERSION)

build:
	make for-version VERSION=7.4 RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
#	make for-version VERSION=8.0 RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE) (NOT SUPPORTED)
#	make for-version VERSION=8.1 RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE) (NOT SUPPORTED)

for-version:
ifeq ($(VERSION), 7.4)
	docker buildx build --platform linux/amd64 --pull --tag $(REPO_EXT):$(RELEASE_TAG) --build-arg PHP_VERSION=$(RELEASE_TAG) --push .
	docker buildx imagetools create --tag $(REPO_EXT):$(RELEASE_TAG_SHORT) $(REPO_EXT):$(RELEASE_TAG)
endif
