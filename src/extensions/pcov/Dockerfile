ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} AS ext

# https://pecl.php.net/package/pcov
RUN pecl install pcov

COPY ext-pcov.ini /tmp/ext-pcov.ini

RUN cp `php-config --extension-dir`/pcov.so /tmp/pcov.so

# Build the final image with just the files we need
FROM scratch
COPY --from=ext /tmp/pcov.so /opt/php/extensions/pcov.so
COPY --from=ext /tmp/ext-pcov.ini /opt/php/conf.d/ext-pcov.ini
