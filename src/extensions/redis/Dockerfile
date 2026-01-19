ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} AS ext

# https://pecl.php.net/package/redis
# https://github.com/phpredis/phpredis

RUN apt-get update && apt-get install -y git && apt-get clean

RUN if [ $(php -r "echo PHP_VERSION_ID;") -ge 80500 ]; then \
    git clone --branch master --depth 1 https://github.com/igbinary/igbinary.git /usr/src/php/ext/igbinary && \
    docker-php-ext-install igbinary && \
    git clone --branch develop --depth 1 https://github.com/phpredis/phpredis.git /usr/src/php/ext/redis && \
    docker-php-ext-configure redis --enable-redis-igbinary && \
    docker-php-ext-install redis; \
  else \
    pecl install igbinary && \
    pecl install -D 'enable-redis-igbinary="yes"' redis; \
  fi

RUN cp `php-config --extension-dir`/igbinary.so /tmp/igbinary.so && \
  cp `php-config --extension-dir`/redis.so /tmp/redis.so && \
  echo 'extension=/opt/php/extensions/igbinary.so' > /tmp/ext-igbinary.ini && \
  echo 'extension=/opt/php/extensions/redis.so' > /tmp/ext-redis.ini

FROM scratch
COPY --from=ext /tmp/igbinary.so /opt/php/extensions/igbinary.so
COPY --from=ext /tmp/ext-igbinary.ini /opt/php/conf.d/ext-igbinary.ini
COPY --from=ext /tmp/redis.so /opt/php/extensions/redis.so
COPY --from=ext /tmp/ext-redis.ini /opt/php/conf.d/ext-redis.ini
