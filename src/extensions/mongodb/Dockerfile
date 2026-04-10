ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} AS ext

RUN apt-get update \
  && apt-get install -y libssl-dev \
  && apt-get clean

RUN pecl install -D "enable-mongodb-developer-flags=\"no\" \
enable-mongodb-coverage=\"no\" \
with-mongodb-system-libs=\"no\" \
with-mongodb-client-side-encryption=\"auto\" \
with-mongodb-snappy=\"auto\" \
with-mongodb-zlib=\"auto\" \
with-mongodb-zstd=\"auto\" \
with-mongodb-sasl=\"auto\" \
with-mongodb-ssl=\"auto\" \
enable-mongodb-crypto-system-profile=\"no\" \
with-mongodb-utf8proc=\"bundled\"" \
  mongodb \
  && test -f "$(php-config --extension-dir)/mongodb.so" \
  && docker-php-ext-enable mongodb

RUN mkdir -p /tmp/extensions /tmp/conf.d
RUN cp $(php-config --extension-dir)/mongodb.so /tmp/extensions/mongodb.so && \
  cp /usr/local/etc/php/conf.d/docker-php-ext-mongodb.ini /tmp/conf.d/ext-mongodb.ini && \
  sed -i 's|extension=mongodb|extension=/opt/php/extensions/mongodb.so|g' /tmp/conf.d/ext-mongodb.ini

FROM scratch
COPY --from=ext /tmp/extensions/ /opt/php/extensions/
COPY --from=ext /tmp/conf.d/ /opt/php/conf.d/
