SHELL := /bin/bash
.PHONY: all build for-version

build:
	make for-version VERSION=7.4
	make for-version VERSION=8.0
	make for-version VERSION=8.1

for-version:
	docker buildx build --platform linux/amd64,linux/arm64 --pull --tag xiponlineapplications/php-extra-mysql:$(VERSION) --build-arg PHP_VERSION=$(VERSION) --push .
