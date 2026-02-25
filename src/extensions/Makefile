include common.Makefile
.PHONY: build ext-%

build: ext-amqp ext-bcmath ext-composer ext-curl ext-datadog ext-gd ext-imagick ext-intl ext-mbstring ext-mongodb ext-mysql ext-opcache ext-pcntl ext-pcov ext-pgsql ext-rdkafka ext-redis ext-saxonc ext-soap ext-sockets ext-xdebug ext-xml ext-xsl ext-zip
	echo "Done building all extensions..."

ext-%:
	cd $* ; $(MAKE) build RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)

dev-ext-%:
	cd $* ; $(MAKE) build-$(DEV_BUILD_VERSION) RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)
