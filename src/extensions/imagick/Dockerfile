ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} AS ext

RUN apt-get update && apt-get install -y libmagickwand-dev --no-install-recommends && apt-get clean

RUN pecl install imagick && docker-php-ext-enable imagick

RUN mkdir -p /tmp/extensions /tmp/conf.d
RUN cp `php-config --extension-dir`/imagick.so /tmp/extensions/imagick.so
RUN cp /usr/local/etc/php/conf.d/docker-php-ext-imagick.ini /tmp/conf.d/ext-imagick.ini

USER root
RUN mkdir -p /tmp/lib64 \
  && cp -d `find /usr/lib -name "libMagick*.so*"` /tmp/lib64/ \
  && cp -d `find /usr/lib -name "libgomp.so*"` /tmp/lib64/

FROM scratch
COPY --from=ext /tmp/extensions/ /opt/php/extensions/
COPY --from=ext /tmp/conf.d /opt/php/conf.d/
COPY --from=ext /tmp/lib64 /opt/php/lib64/
