ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} as ext

RUN set -xe; \
  pecl install xdebug;

COPY ext-xdebug.ini /tmp/ext-xdebug.ini

RUN cp `php-config --extension-dir`/xdebug.so /tmp/xdebug.so

# Build the final image with just the files we need
FROM scratch

# Copy things we installed to the final image
COPY --from=ext /tmp/xdebug.so /opt/php/extensions/xdebug.so
COPY --from=ext /tmp/ext-xdebug.ini /opt/php/conf.d/ext-xdebug.ini
