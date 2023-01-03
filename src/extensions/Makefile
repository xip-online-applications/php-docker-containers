SHELL := /bin/bash
.PHONY: build

REPO_BASE := $(REPO)-extra

build: amqp bcmath composer curl datadog gd intl mbstring mongodb mysql opcache pcntl redis saxonc xdebug xml zip node
	echo "Done building all extensions!"

amqp:
	cd amqp ; make build RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)

bcmath:
	cd bcmath ; make build RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)

composer:
	cd composer ; make build RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)

curl:
	cd curl ; make build RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)

datadog:
	cd datadog ; make build RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)

gd:
	cd gd ; make build RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)

intl:
	cd intl ; make build RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)

mbstring:
	cd mbstring ; make build RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)

mongodb:
	cd mongodb ; make build RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)

mysql:
	cd mysql ; make build RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)

opcache:
	cd opcache ; make build RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)

pcntl:
	cd pcntl ; make build RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)

redis:
	cd redis ; make build RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)

saxonc:
	cd saxonc ; make build RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)

xdebug:
	cd xdebug ; make build RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)

xml:
	cd xml ; make build RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)

zip:
	cd zip ; make build RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)

node:
	cd node ; make build RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)
