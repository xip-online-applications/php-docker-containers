include common.Makefile
.PHONY: build ext-%

build: ext-amqp ext-bcmath ext-composer ext-curl ext-datadog ext-gd ext-intl ext-mbstring ext-mongodb ext-mysql ext-nodejs ext-opcache ext-pcntl ext-redis ext-saxonc ext-xdebug ext-xml ext-xsl ext-zip ext-python ext-supervisor
	echo "Done building all extensions!"

ext-%:
	cd $* ; $(MAKE) build RELEASE=$(RELEASE) REPO=$(REPO) REPO_BASE=$(REPO_BASE)
