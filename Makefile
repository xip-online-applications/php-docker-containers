SHELL := /bin/bash
.PHONY: all base extensions

all:
	make base
	make extensions

base: # Build the custom extensions
	cd src/base ; make build

extensions: # Build the custom extensions
	cd src/extensions ; make build
