ARG PHP_VERSION
FROM xiponlineapplications/php:$PHP_VERSION AS ext

RUN docker-php-ext-install pdo pdo_mysql

RUN mkdir -p /tmp/extensions && mkdir -p /tmp/conf.d

RUN cp `php-config --extension-dir`/pdo_mysql.so /tmp/extensions/pdo_mysql.so \
    && cp `php-config --extension-dir`/pdo.so /tmp/extensions/pdo.so

COPY ext-mysql.ini /tmp/conf.d/ext-mysql.ini

FROM scratch
COPY --from=ext /tmp/extensions/ /opt/php/extensions/
COPY --from=ext /tmp/conf.d/ /opt/php/conf.d/
