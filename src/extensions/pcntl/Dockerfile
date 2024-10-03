ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} AS ext

RUN docker-php-ext-install pcntl

RUN mkdir -p /tmp/extensions /tmp/conf.d
RUN cp `php-config --extension-dir`/pcntl.so /tmp/extensions/pcntl.so && \
  cp /usr/local/etc/php/conf.d/docker-php-ext-pcntl.ini /tmp/conf.d/ext-pcntl.ini && \
  sed -i 's|extension=|extension=/opt/php/extensions/|g' /tmp/conf.d/ext-pcntl.ini

FROM scratch
COPY --from=ext /tmp/extensions/ /opt/php/extensions/
COPY --from=ext /tmp/conf.d /opt/php/conf.d/
