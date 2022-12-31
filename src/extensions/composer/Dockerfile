ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} as ext

# Download composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# The definitive build
FROM scratch
COPY --from=ext /usr/local/bin/composer /opt/bin/composer
