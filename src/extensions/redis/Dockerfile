ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} AS ext

RUN pecl install igbinary
RUN pecl install -D 'enable-redis-igbinary="yes"' redis

RUN cp `php-config --extension-dir`/igbinary.so /tmp/igbinary.so && \
  cp `php-config --extension-dir`/redis.so /tmp/redis.so && \
  echo 'extension=/opt/php/extensions/igbinary.so' > /tmp/ext-igbinary.ini && \
  echo 'extension=/opt/php/extensions/redis.so' > /tmp/ext-redis.ini

FROM scratch
COPY --from=ext /tmp/igbinary.so /opt/php/extensions/igbinary.so
COPY --from=ext /tmp/ext-igbinary.ini /opt/php/conf.d/ext-igbinary.ini
COPY --from=ext /tmp/redis.so /opt/php/extensions/redis.so
COPY --from=ext /tmp/ext-redis.ini /opt/php/conf.d/ext-redis.ini
