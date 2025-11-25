NODEJS_VERSION := $(shell ./get-node-lts-version.sh)

include ../common.Makefile

for-version:
	docker buildx build \
		--cache-from type=registry,ref=$(REPO_EXT):$(VERSION)-cache \
		--cache-to type=registry,ref=$(REPO_EXT):$(VERSION)-cache,mode=max \
		--platform linux/amd64,linux/arm64 \
		--pull \
		--tag $(REPO_EXT):$(RELEASE_TAG) \
		--build-arg NODEJS_VERSION=$(NODEJS_VERSION) \
		--push .
	docker buildx imagetools create --tag $(REPO_EXT):$(RELEASE_TAG_SHORT) $(REPO_EXT):$(RELEASE_TAG)
