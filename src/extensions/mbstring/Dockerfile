ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} AS ext

RUN apt-get update && apt-get install -y libonig-dev && \
    apt-get clean && \
    docker-php-ext-install mbstring && \
    mkdir -p /tmp/extensions /tmp/conf.d && \
    mv `php-config --extension-dir`/mbstring.so /tmp/extensions/mbstring.so

COPY ext-mbstring.ini /tmp/conf.d/ext-mbstring.ini

FROM scratch
COPY --from=ext /tmp/extensions/ /opt/php/extensions/
COPY --from=ext /tmp/conf.d /opt/php/conf.d/
