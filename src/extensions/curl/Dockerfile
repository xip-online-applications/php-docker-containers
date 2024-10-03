ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} AS ext

RUN apt-get update && apt-get install -y libcurl3-dev libcurl4-openssl-dev \
  && apt-get clean

RUN docker-php-ext-install curl

RUN mkdir -p /tmp/extensions /tmp/conf.d
RUN mv `php-config --extension-dir`/curl.so /tmp/extensions/curl.so \
  && echo "extension=/opt/php/extensions/curl.so" >> /tmp/conf.d/ext-curl.ini

FROM scratch
COPY --from=ext /tmp/extensions/ /opt/php/extensions/
COPY --from=ext /tmp/conf.d /opt/php/conf.d/
