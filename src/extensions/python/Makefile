RELEASE_TAG_SHORT_NO_PATCH = $$(echo "$${VERSION%.*}")
RELEASE_TAG_SHORT_JUST_MAJOR = $$(echo "$${VERSION%.*.*}")
BUILD_PREREQS := build-3.11.8 build-3.12.7

include ../common.Makefile

for-version:
	docker buildx build --cache-from type=registry,ref=$(REPO_EXT):cache --cache-to type=registry,ref=$(REPO_EXT):cache,mode=max --pull --tag $(REPO_EXT):$(RELEASE_TAG) --build-arg VERSION=$(VERSION) --push .
	# Just as :X.X.X
	docker buildx imagetools create --tag $(REPO_EXT):$(RELEASE_TAG_SHORT) $(REPO_EXT):$(RELEASE_TAG)
	# Just as :X.X
	docker buildx imagetools create --tag $(REPO_EXT):$(RELEASE_TAG_SHORT_NO_PATCH) $(REPO_EXT):$(RELEASE_TAG)
	# Just as :X
	docker buildx imagetools create --tag $(REPO_EXT):$(RELEASE_TAG_SHORT_JUST_MAJOR) $(REPO_EXT):$(RELEASE_TAG)
