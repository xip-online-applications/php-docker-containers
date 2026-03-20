ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} AS ext

# https://pecl.php.net/package/apcu
# https://github.com/krakjoe/apcu

RUN docker-php-source extract && \
  pecl install --configureoptions 'enable-apcu-debug="no"' apcu && \
  docker-php-ext-enable apcu

RUN mkdir -p /tmp/extensions /tmp/conf.d
RUN mv `php-config --extension-dir`/apcu.so /tmp/extensions/apcu.so
RUN echo "extension=/opt/php/extensions/apcu.so" >> /tmp/conf.d/ext-apcu.ini

FROM scratch
COPY --from=ext /tmp/extensions/ /opt/php/extensions/
COPY --from=ext /tmp/conf.d /opt/php/conf.d/
