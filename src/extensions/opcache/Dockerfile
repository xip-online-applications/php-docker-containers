# TODO: This is already built-in since PHP 8.5, so just remove it after PHP 8.4 has been end-of-life

ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} AS ext

RUN mkdir -p /tmp/extensions /tmp/conf.d
COPY ext-opcache.ini /tmp/conf.d/ext-opcache.ini

RUN if [ $(php -r "echo PHP_VERSION_ID;") -ge 80500 ]; then \
    touch /tmp/extensions/opcache.so && \
    echo "" | tee /tmp/conf.d/ext-opcache.ini; \
  else \
    docker-php-ext-install opcache && \
    cp `php-config --extension-dir`/opcache.so /tmp/extensions/opcache.so; \
  fi

FROM scratch
COPY --from=ext /tmp/extensions/ /opt/php/extensions/
COPY --from=ext /tmp/conf.d /opt/php/conf.d/
