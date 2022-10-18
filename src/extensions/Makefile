SHELL := /bin/bash
.PHONY: all build

build:
	cd bcmath ; make build
	cd composer ; make build
	cd curl ; make build
	cd datadog ; make build
	cd intl ; make build
	cd mbstring ; make build
	cd mongodb ; make build
	cd mysql ; make build
	cd opcache ; make build
	cd pcntl ; make build
	cd redis ; make build
	cd saxonc ; make build
	cd xdebug ; make build
	cd xml ; make build
	cd zip ; make build

for-version:
	cd bcmath ; make for-version VERSION=$(VERSION)
	cd composer ; make for-version VERSION=$(VERSION)
	cd curl ; make for-version VERSION=$(VERSION)
	cd datadog ; make for-version VERSION=$(VERSION)
	cd intl ; make for-version VERSION=$(VERSION)
	cd mbstring ; make for-version VERSION=$(VERSION)
	cd mongodb ; make for-version VERSION=$(VERSION)
	cd mysql ; make for-version VERSION=$(VERSION)
	cd opcache ; make for-version VERSION=$(VERSION)
	cd pcntl ; make for-version VERSION=$(VERSION)
	cd redis ; make for-version VERSION=$(VERSION)
	cd saxonc ; make for-version VERSION=$(VERSION)
	cd xdebug ; make for-version VERSION=$(VERSION)
	cd xml ; make for-version VERSION=$(VERSION)
	cd zip ; make for-version VERSION=$(VERSION)
