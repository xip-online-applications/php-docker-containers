ARG REPO
ARG PHP_VERSION
FROM $REPO:$PHP_VERSION AS ext

RUN mkdir -p /tmp/conf.d && \
    touch /tmp/conf.d/ext-pcov.ini && \
    touch /tmp/conf.d/ext-xdebug.ini && \
    touch /tmp/conf.d/zz-dev-php.ini

FROM scratch
COPY --from=ext /tmp/conf.d/ /opt/php/conf.d/
