RELEASE_TAG_SHORT_NO_PATCH = $$(echo "$${VERSION%.*}")
RELEASE_TAG_SHORT_JUST_MAJOR = $$(echo "$${VERSION%.*.*}")
BUILD_PREREQS := build-3.12.12

include ../common.Makefile

build-8.1 build-8.2 build-8.3 build-8.4 build-8.5:
	@echo "Skipping PHP version build ($@) for Python"

for-version:
	docker buildx build --cache-from type=registry,ref=$(REPO_EXT):$(VERSION)-cache --cache-to type=registry,ref=$(REPO_EXT):$(VERSION)-cache,mode=max --platform linux/amd64,linux/arm64 --pull --tag $(REPO_EXT):$(RELEASE_TAG) --build-arg VERSION=$(VERSION) --push .
	docker buildx imagetools create --tag $(REPO_EXT):$(RELEASE_TAG_SHORT) $(REPO_EXT):$(RELEASE_TAG)
	docker buildx imagetools create --tag $(REPO_EXT):$(RELEASE_TAG_SHORT_NO_PATCH) $(REPO_EXT):$(RELEASE_TAG)
	docker buildx imagetools create --tag $(REPO_EXT):$(RELEASE_TAG_SHORT_JUST_MAJOR) $(REPO_EXT):$(RELEASE_TAG)
