PHP_VERSION := $(VERSION)
RELEASE_TAG := $(VERSION)-$(SAXON_VERSION).$(RELEASE)
RELEASE_TAG_SHORT := $(VERSION)-$(SAXON_VERSION)

include ../common.Makefile

build: build-8.1 build-8.2 build-8.3 build-8.4
	echo "Done build."

build-%:
	$(MAKE) for-version SAXON_VERSION=12 VERSION=$* RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE) PLATFORM=linux/amd64,linux/arm64

for-version:
	docker buildx build --cache-from type=registry,ref=$(REPO_EXT):cache --cache-to type=registry,ref=$(REPO_EXT):cache,mode=max --platform $(PLATFORM) --pull --tag $(REPO_EXT):$(RELEASE_TAG) --build-arg REPO=$(REPO) --build-arg PHP_VERSION=$(PHP_VERSION) --file $(SAXON_VERSION).Dockerfile --push .
	docker buildx imagetools create --tag $(REPO_EXT):$(RELEASE_TAG_SHORT) $(REPO_EXT):$(RELEASE_TAG)
