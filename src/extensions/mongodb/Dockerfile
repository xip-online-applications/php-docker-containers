ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} as ext

RUN apt-get update && apt-get install -y libssl-dev

RUN yes '' | pecl install mongodb
RUN docker-php-ext-enable mongodb

RUN mkdir -p /tmp/extensions && mkdir -p /tmp/conf.d
RUN cp `php-config --extension-dir`/mongodb.so /tmp/extensions/mongodb.so && \
    cp /usr/local/etc/php/conf.d/docker-php-ext-mongodb.ini /tmp/conf.d/ext-mongodb.ini && \
    sed -i 's|extension=mongodb|extension=/opt/php/extensions/mongodb.so|g' /tmp/conf.d/ext-mongodb.ini

FROM scratch
COPY --from=ext /tmp/extensions/ /opt/php/extensions/
COPY --from=ext /tmp/conf.d/ /opt/php/conf.d/
