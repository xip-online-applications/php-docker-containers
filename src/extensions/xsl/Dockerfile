ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} AS ext

RUN apt-get update && apt-get install -y libxslt1-dev \
  && apt-get clean

RUN docker-php-ext-configure xsl \
    && docker-php-ext-install xsl

RUN mkdir -p /tmp/extensions /tmp/conf.d \
    && cp `php-config --extension-dir`/xsl.so /tmp/extensions/xsl.so \
    && echo "extension=/opt/php/extensions/xsl.so" >> /tmp/conf.d/ext-xsl.ini

USER root
RUN mkdir -p /tmp/lib64 \
    && cp `find /usr/lib -name libexslt.so.0` /tmp/lib64/ \
    && cp `find /usr/lib -name libxslt.so.1` /tmp/lib64/

FROM scratch
COPY --from=ext /tmp/extensions/ /opt/php/extensions/
COPY --from=ext /tmp/conf.d /opt/php/conf.d/
COPY --from=ext /tmp/lib64 /opt/php/lib64/
