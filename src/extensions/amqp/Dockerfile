ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} AS ext

RUN apt-get update && apt-get install -y librabbitmq-dev \
  && apt-get clean

# Install AMQP
#TODO: get rid of the issue-php85 branch when php-amqp supports PHP 8.5+
RUN docker-php-source extract \
  && if [ $(php -r "echo PHP_VERSION_ID;") -ge 80500 ]; then \
      git clone --branch issue-php85 --depth 1 https://github.com/remicollet/php-amqp.git /usr/src/php/ext/amqp; \
    else \
      git clone --branch latest --depth 1 https://github.com/php-amqp/php-amqp.git /usr/src/php/ext/amqp \
    fi \
  && cd /usr/src/php/ext/amqp \
  && git submodule update --init \
  && docker-php-ext-install amqp

RUN mkdir -p /tmp/extensions /tmp/conf.d
RUN mv `php-config --extension-dir`/amqp.so /tmp/extensions/amqp.so
RUN echo "extension=/opt/php/extensions/amqp.so" >> /tmp/conf.d/ext-amqp.ini

USER root
RUN mkdir -p /tmp/lib64 \
  && cp `find /usr/lib -name librabbitmq.so.4` /tmp/lib64/

FROM scratch
COPY --from=ext /tmp/extensions/ /opt/php/extensions/
COPY --from=ext /tmp/conf.d /opt/php/conf.d/
COPY --from=ext /tmp/lib64 /opt/php/lib64/
