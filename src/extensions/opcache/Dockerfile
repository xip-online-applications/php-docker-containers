# TODO: This is already built-in since PHP 8.5, so just remove it after PHP 8.4 has been end-of-life

ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} AS ext

RUN docker-php-ext-install opcache || true

RUN mkdir -p /tmp/extensions /tmp/conf.d
RUN mv `php-config --extension-dir`/opcache.so /tmp/extensions/opcache.so

COPY ext-opcache.ini /tmp/conf.d/ext-opcache.ini

FROM scratch
COPY --from=ext /tmp/extensions/ /opt/php/extensions/
COPY --from=ext /tmp/conf.d /opt/php/conf.d/
