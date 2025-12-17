include common.Makefile
.PHONY: prepare docker-login all base extensions release

DEV_BUILD_VERSION := 8.5

prepare:
	docker buildx inspect php-builder >/dev/null 2>&1 || docker buildx create --name php-builder --platform "linux/amd64,linux/arm64" --driver docker-container --use
	docker buildx use php-builder
	docker buildx inspect --bootstrap

reset-builder:
	docker buildx rm php-builder || true
	$(MAKE) prepare

docker-login:
	echo ${GITHUB_TOKEN} | docker login ghcr.io -u ${GITHUB_USER} --password-stdin

all: prepare
	$(MAKE) base RELEASE=$(RELEASE) REPO=$(REPO)
	$(MAKE) extensions RELEASE=$(RELEASE) REPO=$(REPO)

base: # Build the custom extensions
	cd src/base ; $(MAKE) build RELEASE=$(RELEASE) REPO=$(REPO)

extensions: # Build the custom extensions
	cd src/extensions ; $(MAKE) build RELEASE=$(RELEASE) REPO=$(REPO)
	cd src/envs ; $(MAKE) build RELEASE=$(RELEASE) REPO=$(REPO)

## Dev stuff

dev-base-%: # Build a release version for a specific extension
	cd src/base ; $(MAKE) build-$* RELEASE=$(RELEASE) REPO=$(REPO)

dev-extension-%: # Build a release version for a specific extension
	cd src/extensions ; $(MAKE) dev-ext-$* RELEASE=$(RELEASE) REPO=$(REPO) DEV_BUILD_VERSION=$(DEV_BUILD_VERSION)

dev-env-%: # Build a release version for a specific environment
	cd src/envs ; $(MAKE) env-$* RELEASE=$(RELEASE) REPO=$(REPO)

## Release stuff

release: # Build a release version
	$(MAKE) all RELEASE=$(RELEASE) REPO=$(PROD_REPO)

release-base: # Build a release version for the base containers
	$(MAKE) base RELEASE=$(RELEASE) REPO=$(PROD_REPO)

release-extensions: # Build a release version for the extensions
	$(MAKE) extensions RELEASE=$(RELEASE) REPO=$(PROD_REPO)

release-base-%: # Build a release version for a specific extension
	cd src/base ; $(MAKE) build-$* RELEASE=$(RELEASE) REPO=$(PROD_REPO)

release-extension-%: # Build a release version for a specific extension
	cd src/extensions ; $(MAKE) ext-$* RELEASE=$(RELEASE) REPO=$(PROD_REPO)

release-env-%: # Build a release version for a specific environment
	cd src/envs ; $(MAKE) env-$* RELEASE=$(RELEASE) REPO=$(PROD_REPO)
