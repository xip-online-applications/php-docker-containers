SHELL := /bin/bash
.PHONY: all base extensions for-version

all:
	make base
	make extensions

base: # Build the custom extensions
	cd src/base ; make build

extensions: # Build the custom extensions
	cd src/extensions ; make build
	cd src/envs ; make build

for-version: # Build for a specific PHP version
	cd src/base; make for-version VERSION=$(VERSION)
	cd src/extensions; make for-version VERSION=$(VERSION)
	cd src/envs; make for-version VERSION=$(VERSION)
