SHELL := /bin/bash
.PHONY: build for-version

REPO_BASE := $(REPO)-extra

build:
	cd bcmath ; make build RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd composer ; make build RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd curl ; make build RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd datadog ; make build RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd gd ; make build RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd intl ; make build RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd mbstring ; make build RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd mongodb ; make build RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd mysql ; make build RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd opcache ; make build RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd pcntl ; make build RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd redis ; make build RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd saxonc ; make build RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd xdebug ; make build RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd xml ; make build RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd zip ; make build RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd node ; make build RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)

for-version:
	cd bcmath ; make for-version VERSION=$(VERSION) RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd composer ; make for-version VERSION=$(VERSION) RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd curl ; make for-version VERSION=$(VERSION) RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd datadog ; make for-version VERSION=$(VERSION) RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd gd ; make for-version VERSION=$(VERSION) RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd intl ; make for-version VERSION=$(VERSION) RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd mbstring ; make for-version VERSION=$(VERSION) RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd mongodb ; make for-version VERSION=$(VERSION) RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd mysql ; make for-version VERSION=$(VERSION) RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd opcache ; make for-version VERSION=$(VERSION) RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd pcntl ; make for-version VERSION=$(VERSION) RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd redis ; make for-version VERSION=$(VERSION) RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd saxonc ; make for-version VERSION=$(VERSION) RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd xdebug ; make for-version VERSION=$(VERSION) RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd xml ; make for-version VERSION=$(VERSION) RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd xsl ; make for-version VERSION=$(VERSION) RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd zip ; make for-version VERSION=$(VERSION) RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
	cd node ; make build RELEASE=$(RELEASE) REPO_BASE=$(REPO_BASE)
