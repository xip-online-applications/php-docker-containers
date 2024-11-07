ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} AS ext

# https://pecl.php.net/package/pcov
RUN pecl install pcov

COPY ext-pcov.ini /tmp/ext-pcov.ini

# Build the final image with just the files we need
FROM scratch
COPY --from=ext /tmp/ext-pcov.ini /opt/php/conf.d/ext-pcov.ini
