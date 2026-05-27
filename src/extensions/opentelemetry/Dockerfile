ARG REPO
ARG PHP_VERSION

FROM ${REPO}:${PHP_VERSION} AS ext

# https://pecl.php.net/package/opentelemetry
# https://github.com/open-telemetry/opentelemetry-php-instrumentation

RUN MAKE="make -j$(nproc)" pecl install opentelemetry && \
    cp `php-config --extension-dir`/opentelemetry.so /tmp/opentelemetry.so

RUN mkdir -p /opt/extension && mkdir -p /opt/conf.d

WORKDIR /opt/extension

RUN cp /tmp/opentelemetry.so ./ \
    && test -f ./opentelemetry.so

WORKDIR /opt/conf.d

RUN echo "extension=/opt/php/extensions/opentelemetry.so" > ext-opentelemetry.ini

# The definitive build
FROM scratch

COPY --from=ext /opt/conf.d/ /opt/php/conf.d/
COPY --from=ext /opt/extension/ /opt/php/extensions/
