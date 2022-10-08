SHELL := /bin/bash
.PHONY: all build for-version

build:
	make for-version VERSION=7.4
#	make for-version VERSION=8.0 (NOT SUPPORTED)
#	make for-version VERSION=8.1 (NOT SUPPORTED)

for-version:
	docker buildx build --platform linux/amd64 --pull --tag xiponlineapplications/php-extra-saxonc:$(VERSION) --build-arg PHP_VERSION=$(VERSION) --push .
