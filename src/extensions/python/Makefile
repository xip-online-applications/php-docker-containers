SHELL := /bin/bash
.PHONY: build for-version

REPO_EXT := $(REPO_BASE)-python
RELEASE_TAG := $(VERSION).$(RELEASE)
RELEASE_TAG_SHORT := $(VERSION)
RELEASE_TAG_SHORT_NO_PATCH = $$(echo "$${VERSION%.*}")
RELEASE_TAG_SHORT_JUST_MAJOR = $$(echo "$${VERSION%.*.*}")

build: build-3.11.4
	echo "Done build."

build-%:
	$(MAKE) for-version VERSION=$* RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)

for-version:
	docker buildx build --cache-from type=gha --cache-to type=gha,mode=max --platform linux/amd64,linux/arm64 --pull --tag $(REPO_EXT):$(RELEASE_TAG) --build-arg VERSION=$(VERSION) --push .
	# Just as :X.X.X
	docker buildx imagetools create --tag $(REPO_EXT):$(RELEASE_TAG_SHORT) $(REPO_EXT):$(RELEASE_TAG)
	# Just as :X.X
	docker buildx imagetools create --tag $(REPO_EXT):$(RELEASE_TAG_SHORT_NO_PATCH) $(REPO_EXT):$(RELEASE_TAG)
	# Just as :X
	docker buildx imagetools create --tag $(REPO_EXT):$(RELEASE_TAG_SHORT_JUST_MAJOR) $(REPO_EXT):$(RELEASE_TAG)
