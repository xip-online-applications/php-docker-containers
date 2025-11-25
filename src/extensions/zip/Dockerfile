ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} AS ext

RUN apt-get update && apt-get install -y libzip-dev \
  && apt-get clean

RUN docker-php-ext-install zip

RUN mkdir -p /tmp/extensions /tmp/conf.d /tmp/lib64
RUN mv `php-config --extension-dir`/zip.so /tmp/extensions/zip.so \
  && echo "extension=/opt/php/extensions/zip.so" >> /tmp/conf.d/ext-zip.ini \
  && cp -d `find /usr/lib -name "libzip.so*"` /tmp/lib64/

FROM scratch
COPY --from=ext /tmp/extensions/ /opt/php/extensions/
COPY --from=ext /tmp/conf.d /opt/php/conf.d/
COPY --from=ext /tmp/lib64 /opt/php/lib64/
