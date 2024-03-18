ARG REPO
ARG PHP_VERSION
FROM ${REPO}-extra-xdebug:$PHP_VERSION AS xdebug

FROM scratch
COPY --from=xdebug /opt /opt
COPY dev-php.ini /opt/php/conf.d/zz-dev-php.ini
