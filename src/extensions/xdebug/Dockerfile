ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} as ext

# https://pecl.php.net/package/xdebug
RUN if [ $(php -r "echo PHP_MAJOR_VERSION;") = "8" ]; then \
    pecl install xdebug; \
  else \
    pecl install xdebug-3.1.5; \
  fi

COPY ext-xdebug.ini /tmp/ext-xdebug.ini

RUN cp `php-config --extension-dir`/xdebug.so /tmp/xdebug.so

# Build the final image with just the files we need
FROM scratch
COPY --from=ext /tmp/xdebug.so /opt/php/extensions/xdebug.so
COPY --from=ext /tmp/ext-xdebug.ini /opt/php/conf.d/ext-xdebug.ini
