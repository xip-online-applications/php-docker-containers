FROM xiponlineapplications/php-extra-composer:8.1 as composer
FROM xiponlineapplications/php-extra-mysql:8.1 as mysql
FROM xiponlineapplications/php-extra-redis:8.1 as redis
FROM xiponlineapplications/php-extra-xdebug:8.1 as xdebug

FROM xiponlineapplications/php:8.1-fpm

EXPOSE 9003

COPY --from=composer /opt /opt
COPY --from=mysql /opt /opt
COPY --from=redis /opt /opt
COPY --from=xdebug /opt /opt
