ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} AS ext

RUN apt-get update && apt-get install -y libpq-dev && apt-get clean
RUN docker-php-ext-install pgsql pdo_pgsql

RUN mkdir -p /tmp/extensions && mkdir -p /tmp/conf.d

RUN cp `php-config --extension-dir`/pgsql.so /tmp/extensions/pgsql.so \
  && cp `php-config --extension-dir`/pdo_pgsql.so /tmp/extensions/pdo_pgsql.so

COPY ext-pgsql.ini /tmp/conf.d/ext-pgsql.ini

FROM scratch
COPY --from=ext /tmp/extensions/ /opt/php/extensions/
COPY --from=ext /tmp/conf.d/ /opt/php/conf.d/
