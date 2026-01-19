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
  lsb-release

RUN if [ "$(lsb_release -sc)" = "bookworm" ]; then echo "deb http://deb.debian.org/debian bookworm-backports main" > /etc/apt/sources.list.d/bookworm-backports.list; apt-get update && apt-get install -y -t bookworm-backports libsharpyuv0; \
  else apt-get install -y libsharpyuv0; \
  fi \
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
RUN mkdir -p /tmp/lib64 && \
  find /usr/lib -name libpng16.so.16 -exec cp {} /tmp/lib64/ \; && \
  [ -f /tmp/lib64/libpng16.so.16 ] || { echo "Error: libpng16.so.16 is missing"; exit 1; } && \
  find /usr/lib -name libjpeg.so.62 -exec cp {} /tmp/lib64/ \; && \
  [ -f /tmp/lib64/libjpeg.so.62 ] || { echo "Error: libjpeg.so.62 is missing"; exit 1; } && \
  find /usr/lib -name libfreetype.so.6 -exec cp {} /tmp/lib64/ \; && \
  [ -f /tmp/lib64/libfreetype.so.6 ] || { echo "Error: libfreetype.so.6 is missing"; exit 1; } && \
  find /usr/lib -name libgmp.so.10 -exec cp {} /tmp/lib64/ \; && \
  [ -f /tmp/lib64/libgmp.so.10 ] || { echo "Error: libgmp.so.10 is missing"; exit 1; } && \
  find /usr/lib \( -name libwebp.so.7 -o -name libwebp.so.6 \) -exec cp {} /tmp/lib64/ \; && \
  ( [ -f /tmp/lib64/libwebp.so.7 ] || \
  [ -f /tmp/lib64/libwebp.so.6 ] ) || { echo "Error: libwebp.so.* is missing"; exit 1; } && \
  find /usr/lib -name libsharpyuv.so.0 -exec cp {} /tmp/lib64/ \; && \
  [ -f /tmp/lib64/libsharpyuv.so.0 ] || { echo "Error: libsharpyuv.so.0 is missing"; exit 1; }

FROM scratch
COPY --from=ext /tmp/extensions/ /opt/php/extensions/
COPY --from=ext /tmp/conf.d /opt/php/conf.d/
COPY --from=ext /tmp/lib64 /opt/php/lib64/
