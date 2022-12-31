ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} as ext

RUN docker-php-ext-install opcache

RUN mkdir -p /tmp/extensions /tmp/conf.d
RUN mv `php-config --extension-dir`/opcache.so /tmp/extensions/opcache.so

COPY ext-opcache.ini /tmp/conf.d/ext-opcache.ini

FROM scratch
COPY --from=ext /tmp/extensions/ /opt/php/extensions/
COPY --from=ext /tmp/conf.d /opt/php/conf.d/
