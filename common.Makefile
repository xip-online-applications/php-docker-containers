SHELL := /bin/bash

include $(dir $(lastword $(MAKEFILE_LIST)))arch.Makefile

RELEASE ?= "x-latest"
PROD_REPO ?= ghcr.io/xip-online-applications/php-docker-containers/php

REPO ?= $(PROD_REPO)-dev
REPO_BASE := $(REPO)-extra
