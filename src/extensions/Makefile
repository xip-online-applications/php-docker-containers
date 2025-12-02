include common.Makefile
.PHONY: build ext-%

build: ext-amqp ext-bcmath ext-composer ext-curl ext-datadog ext-gd ext-intl ext-mbstring ext-mongodb ext-mysql ext-nodejs ext-opcache ext-pcov ext-pcntl ext-pgsql ext-redis ext-soap ext-saxonc ext-xdebug ext-xml ext-xsl ext-zip ext-sockets ext-kafka
	echo "Done building all extensions!"

ext-%:
	cd $* ; $(MAKE) build RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)

dev-ext-%:
	cd $* ; $(MAKE) build-$(DEV_BUILD_VERSION) RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)
