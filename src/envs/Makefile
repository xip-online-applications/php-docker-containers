SHELL := /bin/bash
.PHONY: build for-version

build:
	cd dev ; make build
	cd prod ; make build

for-version:
	cd dev ; make for-version VERSION=$(VERSION)
	cd prod ; make for-version VERSION=$(VERSION)
