# PHP 7.4 is end of life. This image is a one-off build of php-src branch PHP-7.4-CVE-2026-109618-109619,
# which adds the fixes for CVE-2026-109618 and CVE-2026-109619 on top of PHP 7.4.
# It is built only by .github/workflows/php-7.4.yaml (manual trigger), not by the regular pipeline.
#
# Based on the last docker-library/php 7.4 bullseye Dockerfiles:
# https://github.com/docker-library/php/tree/f2999de80bd83a2ab1e0f4b14208deff6e08936f~1/7.4/bullseye
# Changes from upstream:
# - PHP is built from a pinned php-src commit instead of the php.net release tarball (there is none for this patch).
# - cli and fpm are targets of one Dockerfile; the shared build step lives in docker-php-build.
# - Bullseye stays the base image: PHP 7.4 doesn't build against OpenSSL 3 (bookworm and later).
#   It is end of life too, so apt uses archive.debian.org and gets no further security updates.
#
# Build: docker buildx build --target cli|fpm .

FROM debian:bullseye-slim AS base

# Debian 11 (bullseye) is end of life and its packages have moved to archive.debian.org.
RUN sed -i 's|deb.debian.org|archive.debian.org|g' /etc/apt/sources.list

# prevent Debian's PHP packages from being installed
# https://github.com/docker-library/php/pull/542
RUN set -eux; \
	{ \
		echo 'Package: php*'; \
		echo 'Pin: release *'; \
		echo 'Pin-Priority: -1'; \
	} > /etc/apt/preferences.d/no-debian-php

# dependencies required for running "phpize"
# (see persistent deps below)
ENV PHPIZE_DEPS \
		autoconf \
		dpkg-dev \
		file \
		g++ \
		gcc \
		libc-dev \
		make \
		pkg-config \
		re2c

# persistent / runtime deps
RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		$PHPIZE_DEPS \
		ca-certificates \
		curl \
		xz-utils \
	; \
	rm -rf /var/lib/apt/lists/*

ENV PHP_INI_DIR /usr/local/etc/php
RUN set -eux; \
	mkdir -p "$PHP_INI_DIR/conf.d"; \
# allow running as an arbitrary user (https://github.com/docker-library/php/issues/743)
	[ ! -d /var/www/html ]; \
	mkdir -p /var/www/html; \
	chown www-data:www-data /var/www/html; \
	chmod 777 /var/www/html

# Apply stack smash protection to functions using local buffers and alloca()
# Make PHP's main executable position-independent (improves ASLR security mechanism, and has no performance impact on x86_64)
# Enable optimization (-O2)
# Enable linker optimization (this sorts the hash buckets to improve cache locality, and is non-default)
# https://github.com/docker-library/php/issues/272
# -D_LARGEFILE_SOURCE and -D_FILE_OFFSET_BITS=64 (https://www.php.net/manual/en/intro.filesystem.php)
ENV PHP_CFLAGS="-fstack-protector-strong -fpic -fpie -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64"
ENV PHP_CPPFLAGS="$PHP_CFLAGS"
ENV PHP_LDFLAGS="-Wl,-O1 -pie"

# https://github.com/php/php-src/tree/PHP-7.4-CVE-2026-109618-109619
# The version is the one configure.ac declares on that branch.
ENV PHP_VERSION 7.4.34-dev
ENV PHP_SRC_REPO="https://github.com/php/php-src.git" PHP_SRC_BRANCH="PHP-7.4-CVE-2026-109618-109619"
ENV PHP_SRC_COMMIT="712e60f9edfd03f0960fc4fc3c2c375f42b90aa2"

# There is no release tarball for this patch, so build /usr/src/php.tar.xz the way a release tarball is made:
# check out the pinned commit (git verifies the content against the commit hash), then generate configure
# and the parsers/lexers, so docker-php-source and docker-php-ext-install work as usual.
RUN set -eux; \
	\
	savedAptMark="$(apt-mark showmanual)"; \
	apt-get update; \
	apt-get install -y --no-install-recommends bison git; \
	rm -rf /var/lib/apt/lists/*; \
	\
	mkdir -p /usr/src/php-src; \
	cd /usr/src/php-src; \
	git init -q; \
	git fetch -q --depth 1 "$PHP_SRC_REPO" "$PHP_SRC_COMMIT"; \
	git checkout -q FETCH_HEAD; \
	[ "$(git rev-parse HEAD)" = "$PHP_SRC_COMMIT" ]; \
	rm -rf .git; \
	./buildconf --force; \
	scripts/dev/genfiles; \
	\
	cd /usr/src; \
	tar -cJf php.tar.xz php-src; \
	rm -rf php-src; \
	\
	apt-mark auto '.*' > /dev/null; \
	apt-mark manual $savedAptMark > /dev/null; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false

COPY docker-php-source docker-php-build /usr/local/bin/


FROM base AS cli

# https://github.com/docker-library/php/pull/1259 (phpdbg), https://github.com/docker-library/php/pull/939#issuecomment-730501748 (embed)
ENV PHP_EXTRA_CONFIGURE_ARGS="--enable-phpdbg --enable-phpdbg-readline --enable-embed"
RUN docker-php-build

COPY docker-php-ext-* docker-php-entrypoint /usr/local/bin/

# sodium was built as a shared module (so that it can be replaced later if so desired), so let's enable it too (https://github.com/docker-library/php/issues/598)
RUN docker-php-ext-enable sodium

ENTRYPOINT ["docker-php-entrypoint"]
CMD ["php", "-a"]


FROM base AS fpm

# https://github.com/bwoebi/phpdbg-docs/issues/1#issuecomment-163872806 ("phpdbg is primarily a CLI debugger, and is not suitable for debugging an fpm stack.")
ENV PHP_EXTRA_CONFIGURE_ARGS="--disable-phpdbg --disable-cgi --enable-fpm --with-fpm-user=www-data --with-fpm-group=www-data"
RUN docker-php-build

COPY docker-php-ext-* /usr/local/bin/
COPY docker-php-entrypoint-fpm /usr/local/bin/docker-php-entrypoint

# sodium was built as a shared module (so that it can be replaced later if so desired), so let's enable it too (https://github.com/docker-library/php/issues/598)
RUN docker-php-ext-enable sodium

ENTRYPOINT ["docker-php-entrypoint"]
WORKDIR /var/www/html

RUN set -eux; \
	cd /usr/local/etc; \
	# for some reason, upstream's php-fpm.conf.default has "include=NONE/etc/php-fpm.d/*.conf"
	sed 's!=NONE/!=!g' php-fpm.conf.default | tee php-fpm.conf > /dev/null; \
	cp php-fpm.d/www.conf.default php-fpm.d/www.conf; \
	{ \
		echo '[global]'; \
		echo 'error_log = /proc/self/fd/2'; \
		echo; echo '; https://github.com/docker-library/php/pull/725#issuecomment-443540114'; echo 'log_limit = 8192'; \
		echo; \
		echo '[www]'; \
		echo '; if we send this to /proc/self/fd/1, it never appears'; \
		echo 'access.log = /proc/self/fd/2'; \
		echo; \
		echo 'clear_env = no'; \
		echo; \
		echo '; Ensure worker stdout and stderr are sent to the main error log.'; \
		echo 'catch_workers_output = yes'; \
		echo 'decorate_workers_output = no'; \
	} | tee php-fpm.d/docker.conf; \
	{ \
		echo '[global]'; \
		echo 'daemonize = no'; \
		echo; \
		echo '[www]'; \
		echo 'listen = 9000'; \
	} | tee php-fpm.d/zz-docker.conf

# Override stop signal to stop process gracefully
# https://github.com/php/php-src/blob/17baa87faddc2550def3ae7314236826bc1b1398/sapi/fpm/php-fpm.8.in#L163
STOPSIGNAL SIGQUIT

EXPOSE 9000
CMD ["php-fpm"]
