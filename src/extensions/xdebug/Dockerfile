ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} AS ext

# https://pecl.php.net/package/xdebug
# https://xdebug.org/docs/compat
RUN apt-get update && apt-get install -y git \
  && apt-get clean

RUN pecl install xdebug-3.5.0 && \
    docker-php-ext-enable xdebug

COPY ext-xdebug.ini /tmp/ext-xdebug.ini

RUN cp `php-config --extension-dir`/xdebug.so /tmp/xdebug.so

# Build the final image with just the files we need
FROM scratch
COPY --from=ext /tmp/xdebug.so /opt/php/extensions/xdebug.so
COPY --from=ext /tmp/ext-xdebug.ini /opt/php/conf.d/ext-xdebug.ini
