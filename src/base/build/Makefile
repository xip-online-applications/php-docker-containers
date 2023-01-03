SHELL := /bin/bash
.PHONY: build for-version

REPO := $(REPO_BASE)
REPO_BUILD := $(REPO_BASE)-build
RELEASE_TAG := $(VERSION).$(RELEASE)
RELEASE_TAG_SHORT := $(VERSION)

build: for-version-7.4 for-version-8.0 for-version-8.1
	echo "Done building base images."

for-version-%:
	$(MAKE) for-version VERSION=$* RELEASE=$(RELEASE)

for-version:
	docker buildx build --cache-from type=gha --cache-to type=gha,mode=max --platform linux/amd64,linux/arm64 --tag $(REPO_BUILD):$(RELEASE_TAG) --file $(VERSION)/Dockerfile --push .
	docker buildx build --cache-from type=gha --cache-to type=gha,mode=max --platform linux/amd64,linux/arm64 --tag $(REPO):$(RELEASE_TAG) --file php.Dockerfile --build-arg REPO_BUILD=$(REPO_BUILD) --build-arg RELEASE_TAG=$(RELEASE_TAG) --push .
	docker buildx imagetools create --tag $(REPO):$(RELEASE_TAG_SHORT) $(REPO):$(RELEASE_TAG)
