SHELL := /bin/bash
.PHONY: all build

build:
	cd dev ; make build
	cd prod ; make build

for-version:
	cd dev ; make for-version VERSION=$(VERSION)
	cd prod ; make for-version VERSION=$(VERSION)
