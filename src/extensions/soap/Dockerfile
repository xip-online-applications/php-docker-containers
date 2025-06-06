ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} AS ext

RUN apt-get update && apt-get install -y libxml2-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \

RUN docker-php-ext-configure soap \
  && docker-php-ext-install soap

RUN mkdir -p /tmp/extensions /tmp/conf.d
RUN mv `php-config --extension-dir`/soap.so /tmp/extensions/soap.so \
  && echo "extension=/opt/php/extensions/soap.so" >> /tmp/conf.d/ext-soap.ini

FROM scratch
COPY --from=ext /tmp/extensions/ /opt/php/extensions/
COPY --from=ext /tmp/conf.d /opt/php/conf.d/
