ARG REPO
ARG PHP_VERSION

FROM ${REPO}:${PHP_VERSION} AS ext

# https://github.com/symfony/php-ext-deepclone

# Install build dependencies
RUN apt-get update && apt-get install -y \
    git \
    autoconf \
    build-essential \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Clone and build the extension
RUN git clone https://github.com/symfony/php-ext-deepclone.git /tmp/php-ext-deepclone

WORKDIR /tmp/php-ext-deepclone

RUN phpize \
    && ./configure \
    && make -j"$(nproc)" \
    && make install

# Copy all files
RUN mkdir -p /opt/extension && mkdir -p /opt/conf.d

WORKDIR /opt/extension

RUN cp "$(php-config --extension-dir)/deepclone.so" ./ \
    && test -f ./deepclone.so

# Create extension ini
WORKDIR /opt/conf.d

RUN echo "extension=/opt/php/extensions/deepclone.so" > ext-deepclone.ini

# The definitive build
FROM scratch

COPY --from=ext /opt/conf.d/ /opt/php/conf.d/
COPY --from=ext /opt/extension/ /opt/php/extensions/
