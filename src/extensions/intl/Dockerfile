ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} AS ext

RUN apt-get update && apt-get install -y libicu-dev \
  && apt-get clean

RUN docker-php-ext-configure intl \
	&& docker-php-ext-install intl

RUN mkdir -p /tmp/extensions /tmp/conf.d
RUN mv `php-config --extension-dir`/intl.so /tmp/extensions/intl.so

COPY ext-intl.ini /tmp/conf.d/ext-intl.ini

FROM scratch
COPY --from=ext /tmp/extensions/ /opt/php/extensions/
COPY --from=ext /tmp/conf.d /opt/php/conf.d/
