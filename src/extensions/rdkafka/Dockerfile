ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} AS ext

RUN apt-get update \
  && apt-get install -y build-essential git libsasl2-dev libssl-dev zlib1g-dev \
  && apt-get clean

WORKDIR /tmp
# https://github.com/confluentinc/librdkafka/releases
ARG LIBRDKAFKA_VERSION="v1.9.2"
RUN git clone --branch "${LIBRDKAFKA_VERSION}" --depth 1 https://github.com/confluentinc/librdkafka.git

WORKDIR /tmp/librdkafka
RUN ./configure \
  && make \
  && make install \
  && pecl install rdkafka \
  && docker-php-ext-enable rdkafka

RUN mkdir -p /tmp/extensions /tmp/conf.d
RUN mv `php-config --extension-dir`/rdkafka.so /tmp/extensions/rdkafka.so

COPY ext-rdkafka.ini /tmp/conf.d/ext-rdkafka.ini

USER root
RUN rm -rf /tmp/librdkafka/*
RUN mkdir -p /tmp/lib64 \
  && cp `find / -name librdkafka.so.1` /tmp/lib64/

FROM scratch
COPY --from=ext /tmp/extensions/ /opt/php/extensions/
COPY --from=ext /tmp/conf.d /opt/php/conf.d/
COPY --from=ext /tmp/lib64 /opt/php/lib64/
