ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} AS ext

# https://github.com/DataDog/dd-trace-php/releases
RUN if ([ $(php -r "echo PHP_MAJOR_VERSION;") -ge "8" ] && [ $(php -r "echo PHP_MINOR_VERSION;") -gt 3 ]); then \
    curl -sSL "https://github.com/DataDog/dd-trace-php/releases/download/1.5.1/datadog-setup.php" --output /tmp/datadog-setup.php \
      && php /tmp/datadog-setup.php --php-bin all --install-dir /opt/share/datadog/ --enable-profiling \
  else \
    curl -sSL "https://github.com/DataDog/dd-trace-php/releases/download/1.4.0/datadog-setup.php" --output /tmp/datadog-setup.php \
      && php /tmp/datadog-setup.php --php-bin all --install-dir /opt/share/datadog/ --enable-profiling \
  fi

# Download and install
RUN curl -sSL "https://github.com/DataDog/dd-trace-php/releases/download/${DATADOG_TRACING_VERSION}/datadog-setup.php" --output /tmp/datadog-setup.php \
  && php /tmp/datadog-setup.php --php-bin all --install-dir /opt/share/datadog/ --enable-profiling

# Copy all files
RUN mkdir -p /opt/extension && mkdir -p /opt/conf.d
WORKDIR /opt/extension
RUN cp "$(php-config --extension-dir)/ddtrace.so" ./ | true && test -f ./ddtrace.so
RUN cp "$(php-config --extension-dir)/ddappsec.so" ./ | true
RUN cp "$(php-config --extension-dir)/datadog-profiling.so" ./ | true

WORKDIR /opt/conf.d
RUN cp "/usr/local/etc/php/conf.d:/opt/php/conf.d/98-ddtrace.ini" ext-datadog.ini | true \
  && cp "/opt/php/conf.d:/usr/local/etc/php/conf.d/98-ddtrace.ini" ext-datadog.ini | true \
  && cp "/usr/local/etc/php/conf.d/98-ddtrace.ini" ext-datadog.ini | true \
  && cp "/opt/php/conf.d/98-ddtrace.ini" ext-datadog.ini | true \
  && test -f ext-datadog.ini

# Fix the datadog ini file
RUN sed -i 's|extension = |extension = /opt/php/extensions/|g' ext-datadog.ini \
  && sed -i 's|datadog.profiling.enabled = 1|datadog.profiling.enabled = 0|g' ext-datadog.ini

# The definitive build
FROM scratch
COPY --from=ext /opt/conf.d/ /opt/php/conf.d/
COPY --from=ext /opt/share/datadog/ /opt/share/datadog/
COPY --from=ext /opt/extension/ /opt/php/extensions/
