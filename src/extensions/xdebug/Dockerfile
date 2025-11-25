ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} AS ext

# https://pecl.php.net/package/xdebug
# https://xdebug.org/docs/compat
RUN apt-get update && apt-get install -y git \
  && apt-get clean

RUN if [ $(php -r "echo PHP_VERSION_ID;") -ge 80500 ]; then \
    git clone --branch master --depth 1 https://github.com/xdebug/xdebug.git /usr/src/php/ext/xdebug \
    && docker-php-ext-install xdebug; \
  elif [ $(php -r "echo PHP_VERSION_ID;") -ge 80100 ]; then \
    pecl install xdebug-3.4.7 \
    && docker-php-ext-enable xdebug; \
  else \
    pecl install xdebug-3.1.5 \
    && docker-php-ext-enable xdebug; \
  fi

COPY ext-xdebug.ini /tmp/ext-xdebug.ini

RUN cp `php-config --extension-dir`/xdebug.so /tmp/xdebug.so

# Build the final image with just the files we need
FROM scratch
COPY --from=ext /tmp/xdebug.so /opt/php/extensions/xdebug.so
COPY --from=ext /tmp/ext-xdebug.ini /opt/php/conf.d/ext-xdebug.ini
