SHELL := /bin/bash
.PHONY: all build

build:
	make for-version VERSION=7.4
	make for-version VERSION=8.0
	make for-version VERSION=8.1

for-version:
	docker buildx build --platform linux/amd64,linux/arm64 --tag xiponlineapplications/php-build:$(VERSION)-fpm --file $(VERSION).Dockerfile --push .
	docker buildx build --platform linux/amd64,linux/arm64 --tag xiponlineapplications/php:$(VERSION)-fpm --file fpm.Dockerfile --build-arg VERSION=$(VERSION) --push .
