SHELL := /bin/bash
.PHONY: all base extensions for-version release

RELEASE ?= "latest"
REPO ?= xiponlineapplications/php-dev

all:
	make base RELEASE=$(RELEASE) REPO=$(REPO)
	make extensions RELEASE=$(RELEASE) REPO=$(REPO)

base: # Build the custom extensions
	cd src/base ; make build RELEASE=$(RELEASE) REPO=$(REPO)

extensions: # Build the custom extensions
	cd src/extensions ; make build RELEASE=$(RELEASE) REPO=$(REPO)
	cd src/envs ; make build RELEASE=$(RELEASE) REPO=$(REPO)

for-version: # Build for a specific PHP version
	cd src/base; make for-version VERSION=$(VERSION) RELEASE=$(RELEASE) REPO=$(REPO)
	cd src/extensions; make for-version VERSION=$(VERSION) RELEASE=$(RELEASE) REPO=$(REPO)
	cd src/envs; make for-version VERSION=$(VERSION) RELEASE=$(RELEASE) REPO=$(REPO)

release: # Build a release version
	make all RELEASE=$(RELEASE) REPO=xiponlineapplications/php

release-for-version: # Build a release version
	make for-version VERSION=$(VERSION) RELEASE=$(RELEASE) REPO=xiponlineapplications/php
