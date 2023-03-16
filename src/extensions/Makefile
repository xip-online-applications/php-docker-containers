SHELL := /bin/bash
.PHONY: build

REPO_BASE := $(REPO)-extra

build: ext-amqp ext-bcmath ext-composer ext-curl ext-datadog ext-gd ext-intl ext-mbstring ext-mongodb ext-mysql ext-nodejs ext-opcache ext-pcntl ext-redis ext-saxonc ext-xdebug ext-xml ext-zip ext-python3
	echo "Done building all extensions!"

ext-%:
	cd $* ; $(MAKE) build RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)
