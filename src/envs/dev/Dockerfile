ARG PHP_VERSION
FROM xiponlineapplications/php-extra-xdebug:$PHP_VERSION as xdebug

FROM scratch
COPY --from=xdebug /opt /opt
COPY dev-php.ini /opt/php/conf.d/zz-dev-php.ini
