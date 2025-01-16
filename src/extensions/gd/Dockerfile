ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} AS ext

# Install dependencies with apt-get
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libgmp-dev \
    libwebp-dev \
    libfreetype6-dev \
    && apt-get clean

# Configure and install GMP
RUN docker-php-ext-configure gmp && docker-php-ext-install gmp

# Configure and install GD with JPEG, WebP, and FreeType support
RUN docker-php-ext-configure gd --with-jpeg --with-webp --with-freetype && docker-php-ext-install gd

RUN mkdir -p /tmp/extensions /tmp/conf.d
RUN mv `php-config --extension-dir`/gmp.so /tmp/extensions/gmp.so \
  && echo "extension=/opt/php/extensions/gmp.so" >> /tmp/conf.d/ext-gmp.ini
RUN mv `php-config --extension-dir`/gd.so /tmp/extensions/gd.so \
  && echo "extension=/opt/php/extensions/gd.so" >> /tmp/conf.d/ext-gd.ini

USER root
RUN mkdir -p /tmp/lib64 \
  && cp `find /usr/lib -name libpng16.so.16` /tmp/lib64/ \
  && cp `find /usr/lib -name libjpeg.so.62` /tmp/lib64/ \
  && cp `find /usr/lib -name libfreetype.so.6` /tmp/lib64/ \
  && cp `find /usr/lib \( -name libwebp.so.7 -o -name libwebp.so.6 \)` /tmp/lib64/

FROM scratch
COPY --from=ext /tmp/extensions/ /opt/php/extensions/
COPY --from=ext /tmp/conf.d /opt/php/conf.d/
COPY --from=ext /tmp/lib64 /opt/php/lib64/
