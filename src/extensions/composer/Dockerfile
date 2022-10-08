ARG PHP_VERSION
FROM xiponlineapplications/php:$PHP_VERSION AS ext

# Download composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# The definitive build
FROM scratch
COPY --from=ext /usr/local/bin/composer /opt/bin/composer
