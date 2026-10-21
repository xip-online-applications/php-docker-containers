PHP_VERSION := $(VERSION)
RELEASE_TAG := $(VERSION)-$(SAXON_VERSION).$(RELEASE)
RELEASE_TAG_SHORT := $(VERSION)-$(SAXON_VERSION)

include ../common.Makefile

build: build-8.2 build-8.3 build-8.4 build-8.5
	echo "Done build."

manifest: manifest-8.2 manifest-8.3 manifest-8.4 manifest-8.5
	echo "Done joining."

build-%:
	$(MAKE) for-version SAXON_VERSION=12 VERSION=$* RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)

manifest-%:
	$(MAKE) manifest-version SAXON_VERSION=12 VERSION=$* RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)

for-version:
	docker buildx build --cache-from type=registry,ref=$(REPO_EXT):$(VERSION)-cache$(ARCH_SUFFIX) --cache-to type=registry,ref=$(REPO_EXT):$(VERSION)-cache$(ARCH_SUFFIX),mode=max --platform $(PLATFORMS) --pull --tag $(REPO_EXT):$(RELEASE_TAG)$(ARCH_SUFFIX) --build-arg REPO=$(REPO) --build-arg PHP_VERSION=$(PHP_VERSION) --file $(SAXON_VERSION).Dockerfile --push .
	$(if $(ARCH),,docker buildx imagetools create --tag $(REPO_EXT):$(RELEASE_TAG_SHORT) $(REPO_EXT):$(RELEASE_TAG))
