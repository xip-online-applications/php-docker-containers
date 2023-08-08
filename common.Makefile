SHELL := /bin/bash

RELEASE ?= "x-latest"
PROD_REPO ?= ghcr.io/xip-online-applications/php-docker-containers/php

REPO ?= $(PROD_REPO)-dev
REPO_BASE := $(REPO)-extra
