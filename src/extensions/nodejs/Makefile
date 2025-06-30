# https://nodejs.org/en/about/previous-releases
# Try to only add the LTS and Maintenance version here

BUILD_PREREQS := build-18 build-20 build-22

include ../common.Makefile

for-version:
	docker buildx build --cache-from type=gha --cache-to type=gha,mode=max --platform linux/amd64,linux/arm64 --pull --tag $(REPO_EXT):$(RELEASE_TAG) --build-arg NODEJS_VERSION=$(VERSION) --push .
	docker buildx imagetools create --tag $(REPO_EXT):$(RELEASE_TAG_SHORT) $(REPO_EXT):$(RELEASE_TAG)
