ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} AS ext

# https://github.com/DataDog/dd-trace-php/releases
# https://docs.datadoghq.com/tracing/trace_collection/compatibility/php/

# Download and install
RUN curl -sSL "https://github.com/DataDog/dd-trace-php/releases/latest/download/datadog-setup.php" --output /tmp/datadog-setup.php && \
  php /tmp/datadog-setup.php --php-bin all --install-dir /opt/share/datadog/ --enable-profiling --enable-appsec

# Copy all files
RUN mkdir -p /opt/extension && mkdir -p /opt/conf.d
WORKDIR /opt/extension
RUN cp "$(php-config --extension-dir)/ddtrace.so" ./ | true && test -f ./ddtrace.so
RUN cp "$(php-config --extension-dir)/ddappsec.so" ./ | true
RUN cp "$(php-config --extension-dir)/datadog-profiling.so" ./ | true

WORKDIR /opt/conf.d

RUN apt-get update && apt-get install -y locate && apt-get clean \
  && updatedb \
  && WHERE98DDTRACE=$(locate 98-ddtrace.ini | head -n 1) \
  && cp "$WHERE98DDTRACE" ext-datadog.ini \
  && if [ ! -f ext-datadog.ini ]; then \
    echo "Error: Could not find datadog ini file" >&2; \
    exit 1; \
  fi

# Fix the datadog ini file
RUN sed -i 's|extension = |extension = /opt/php/extensions/|g' ext-datadog.ini

# The definitive build
FROM scratch
COPY --from=ext /opt/conf.d/ /opt/php/conf.d/
COPY --from=ext /opt/share/datadog/ /opt/share/datadog/
COPY --from=ext /opt/extension/ /opt/php/extensions/
