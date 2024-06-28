ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} AS ext

RUN apt-get update && apt-get install -y libxml2-dev \
  && apt-get clean

RUN docker-php-ext-install xml simplexml

RUN mkdir -p /tmp/extensions && mkdir -p /tmp/conf.d
RUN cp `php-config --extension-dir`/xml.so /tmp/extensions/xml.so && \
    cp `php-config --extension-dir`/simplexml.so /tmp/extensions/simplexml.so && \
    echo "extension=/opt/php/extensions/xml.so" >> /tmp/conf.d/ext-xml.ini && \
    echo "extension=/opt/php/extensions/simplexml.so" >> /tmp/conf.d/ext-simplexml.ini

FROM scratch
COPY --from=ext /tmp/extensions/ /opt/php/extensions/
COPY --from=ext /tmp/conf.d /opt/php/conf.d/
