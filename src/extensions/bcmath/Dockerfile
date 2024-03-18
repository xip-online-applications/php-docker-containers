ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} AS ext

RUN docker-php-ext-install bcmath

RUN mkdir -p /tmp/extensions /tmp/conf.d
RUN mv `php-config --extension-dir`/bcmath.so /tmp/extensions/bcmath.so

COPY ext-bcmath.ini /tmp/conf.d/ext-bcmath.ini

FROM scratch
COPY --from=ext /tmp/extensions/ /opt/php/extensions/
COPY --from=ext /tmp/conf.d /opt/php/conf.d/
