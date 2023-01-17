ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} as ext

# https://github.com/DataDog/dd-trace-php/releases
ARG DATADOG_TRACING_VERSION="0.83.0"

# Download and install
RUN curl -sSL "https://github.com/DataDog/dd-trace-php/releases/download/${DATADOG_TRACING_VERSION}/datadog-setup.php" --output /tmp/datadog-setup.php \
    && php /tmp/datadog-setup.php --php-bin all --install-dir /opt/share/datadog/

# Copy all files
RUN mkdir -p /opt/extension && mkdir -p /opt/conf.d
RUN cp "$(php-config --extension-dir)/ddtrace.so" /opt/extension/ddtrace.so | true \
    && test -f /opt/extension/ddtrace.so
RUN cp "$(php-config --extension-dir)/ddappsec.so" /opt/extension/ddappsec.so | true
RUN cp "$(php-config --extension-dir)/datadog-profiling.so" /opt/extension/datadog-profiling.so | true
RUN cp "/usr/local/etc/php/conf.d:/opt/php/conf.d/98-ddtrace.ini" /opt/conf.d/ext-datadog.ini | true \
    && cp "/usr/local/etc/php/conf.d/98-ddtrace.ini" /opt/conf.d/ext-datadog.ini | true \
    && cp "/opt/php/conf.d/98-ddtrace.ini" /opt/conf.d/ext-datadog.ini | true \
    && test -f /opt/conf.d/ext-datadog.ini

# Fix the datadog ini file
RUN sed -i 's|extension = |extension = /opt/php/extensions/|g' /opt/conf.d/ext-datadog.ini

# The definitive build
FROM scratch
COPY --from=ext /opt/conf.d/ /opt/php/conf.d/
COPY --from=ext /opt/share/datadog/ /opt/share/datadog/
COPY --from=ext /opt/extension/ /opt/php/extensions/
