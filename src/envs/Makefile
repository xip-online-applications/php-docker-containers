include $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/../../common.Makefile

.PHONY: build for-version

build: env-dev env-prod
	echo "Done building environments."

env-%:
	cd $* ; $(MAKE) build RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)
