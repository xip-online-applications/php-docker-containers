include common.Makefile
.PHONY: prepare docker-login all base extensions release

prepare:
	#sudo apt-get update && sudo apt-get install -y qemu-user-static binfmt-support make
	docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
	docker buildx create --platform "linux/amd64,linux/arm64" --use

docker-login:
	echo ${GITHUB_TOKEN} | docker login ghcr.io -u ${GITHUB_USER} --password-stdin

all:
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
	cd src/extensions ; $(MAKE) ext-$* RELEASE=$(RELEASE) REPO=$(REPO)

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
