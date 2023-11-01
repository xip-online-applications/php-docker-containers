ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} AS ext

# The target OS
ARG TARGETARCH

# https://www.saxonica.com/download/c.xml
ARG LIBSAXON_VERSION=12.3
ARG LIBSAXON_ARCHITECTURE=linux
ARG LIBSAXON_ARCHITECTURE_DOWNLOAD=${LIBSAXON_ARCHITECTURE}-x86_64
ARG LIBSAXON_UNZIPPED_FILE_NAME=libsaxon-HEC-${LIBSAXON_ARCHITECTURE}-v${LIBSAXON_VERSION}

ENV SAXONC_HOME=/opt/php/lib64

# Download saxon lib
RUN DEBARCH="x86_64"; \
    if [ "${TARGETARCH}" = "arm64" ]; then DEBARCH="aarch64"; fi; \
    curl -sS -o /libsaxon-setup.zip "https://www.saxonica.com/download/libsaxon-HEC-${LIBSAXON_ARCHITECTURE_DOWNLOAD}-v${LIBSAXON_VERSION}.zip"; \
    unzip /libsaxon-setup.zip -d "/${LIBSAXON_UNZIPPED_FILE_NAME}"

WORKDIR /${LIBSAXON_UNZIPPED_FILE_NAME}/*

# Copy required files
RUN cp libs/nix/* /usr/lib/.

# Build Saxon
RUN export "LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/lib" \
    && cd Saxon.C.API \
    && phpize \
    && ./configure --enable-saxon \
    && make -j$(nproc) \
    && make install

# Prepare files
RUN mkdir -p /tmp/extensions /tmp/conf.d /tmp/lib64
RUN cp "$(php-config --extension-dir)/saxon.so" /tmp/extensions/saxonc.so
RUN echo "extension=/opt/php/extensions/saxonc.so" >> /tmp/conf.d/ext-saxonc.ini
RUN cp /usr/lib/libsaxon-* /tmp/lib64/.

# The definitive build
FROM scratch
COPY --from=ext /tmp/conf.d/ /opt/php/conf.d/
COPY --from=ext /tmp/extensions/ /opt/php/extensions/
COPY --from=ext /tmp/lib64/ /opt/php/lib64/
