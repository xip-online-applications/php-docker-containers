PHP_VERSION := $(VERSION)
RELEASE_TAG := $(VERSION)-$(SAXON_VERSION).$(RELEASE)
RELEASE_TAG_SHORT := $(VERSION)-$(SAXON_VERSION)

include ../common.Makefile

build: build-7.4 build-8.0 build-8.1 build-8.2 build-8.3 build-8.4
	echo "Done build."

build-7.4:
	$(MAKE) for-version SAXON_VERSION=1.1 VERSION=7.4 RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE) PLATFORM=linux/amd64
	$(MAKE) for-version SAXON_VERSION=1.2 VERSION=7.4 RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE) PLATFORM=linux/amd64

build-8.0:
	$(MAKE) for-version SAXON_VERSION=12 VERSION=8.0 RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE) PLATFORM=linux/amd64,linux/arm64
build-8.1:
	$(MAKE) for-version SAXON_VERSION=12 VERSION=8.1 RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE) PLATFORM=linux/amd64,linux/arm64
build-8.2:
	$(MAKE) for-version SAXON_VERSION=12 VERSION=8.2 RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE) PLATFORM=linux/amd64,linux/arm64
build-8.3:
	$(MAKE) for-version SAXON_VERSION=12 VERSION=8.3 RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE) PLATFORM=linux/amd64,linux/arm64
build-8.4:
	$(MAKE) for-version SAXON_VERSION=12 VERSION=8.4 RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE) PLATFORM=linux/amd64,linux/arm64

for-version:
	docker buildx build --cache-from type=gha --cache-to type=gha,mode=max --platform $(PLATFORM) --pull --tag $(REPO_EXT):$(RELEASE_TAG) --build-arg REPO=$(REPO) --build-arg PHP_VERSION=$(PHP_VERSION) --file $(SAXON_VERSION).Dockerfile --push .
	docker buildx imagetools create --tag $(REPO_EXT):$(RELEASE_TAG_SHORT) $(REPO_EXT):$(RELEASE_TAG)
