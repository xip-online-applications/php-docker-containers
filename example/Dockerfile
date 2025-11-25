## This example Dockerfile contains a multi-stage build proces for usage in
## both development and production environments.

# Base is the PHP-FPM version 8.5 image
FROM ghcr.io/xip-online-applications/php-docker-containers/php:8.5-fpm AS development

# Add the MySQL and Redis extensions
COPY --from=ghcr.io/xip-online-applications/php-docker-containers/php-extra-mysql:8.5 /opt /opt
COPY --from=ghcr.io/xip-online-applications/php-docker-containers/php-extra-redis:8.5 /opt /opt

# Require Composer
COPY --from=ghcr.io/xip-online-applications/php-docker-containers/php-extra-composer:8.5 /opt /opt

# Add development settings
COPY --from=ghcr.io/xip-online-applications/php-docker-containers/php-extra-dev:8.5 /opt /opt

#########
# Production image part
##

# Begin with extending the development (above) image
FROM development AS production

# Undo development settings
COPY --from=ghcr.io/xip-online-applications/php-docker-containers/php-extra-prod:8.5 /opt /opt

# ... perform install steps and so on for your application like `COPY ./ ./`, etc.
