ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} AS ext

RUN apt-get update && apt-get install -y libpq-dev && apt-get clean
RUN docker-php-ext-install pgsql pdo_pgsql

RUN mkdir -p /tmp/extensions && mkdir -p /tmp/conf.d

RUN cp `php-config --extension-dir`/pgsql.so /tmp/extensions/pgsql.so && \
  cp `php-config --extension-dir`/pdo_pgsql.so /tmp/extensions/pdo_pgsql.so

COPY ext-pgsql.ini /tmp/conf.d/ext-pgsql.ini

USER root
RUN mkdir -p /tmp/lib64 && \
  cp `find /usr/lib -name libpq.so.5` /tmp/lib64/ && \
  cp `find /usr/lib -name libgssapi_krb5.so.2` /tmp/lib64/ && \
  cp `find /usr/lib -name libldap*.so*` /tmp/lib64/ && \
  cp `find /usr/lib -name liblber*.so*` /tmp/lib64/ && \
  cp `find /usr/lib -name libsasl2.so.2` /tmp/lib64/
