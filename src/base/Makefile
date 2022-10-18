SHELL := /bin/bash
.PHONY: build for-version

build:
	cd build ; make build
	cd fpm ; make build

for-version:
	cd build ; make for-version VERSION=$(VERSION)
	cd fpm ; make for-version VERSION=$(VERSION)
