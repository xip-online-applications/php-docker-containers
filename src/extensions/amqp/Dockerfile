ARG PHP_VERSION
FROM xiponlineapplications/php:$PHP_VERSION AS ext

RUN apt-get update && apt-get install -y librabbitmq-dev

# Install AMQP
RUN docker-php-source extract \
    && git clone --branch master --depth 1 https://github.com/php-amqp/php-amqp.git /usr/src/php/ext/amqp \
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
