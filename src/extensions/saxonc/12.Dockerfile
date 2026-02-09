ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} AS ext

# The target OS
ARG TARGETARCH

#VERSION
# https://www.saxonica.com/download/c.xml
ARG LIBSAXON_VERSION=12-9-0
ARG LIBSAXON_ARCHITECTURE=linux

ENV SAXONC_HOME=/opt/php/lib64

# Download saxon lib
RUN DEBARCH="x86_64"; \
  if [ "${TARGETARCH}" = "arm64" ]; then DEBARCH="arm64"; fi; \
  DOWNLOAD_URL="https://downloads.saxonica.com/SaxonC/HE/12/SaxonCHE-${LIBSAXON_ARCHITECTURE}-${DEBARCH}-${LIBSAXON_VERSION}.zip"; \
  curl -LsS -o /tmp/libsaxon-setup.zip "$DOWNLOAD_URL"; \
  unzip /tmp/libsaxon-setup.zip -d "/tmp/libsaxon"; \
  mv /tmp/libsaxon/*/* /tmp/libsaxon

WORKDIR /tmp/libsaxon

# Copy required files
RUN cp -r SaxonCHE/lib/* /usr/lib/
RUN cp -r SaxonCHE/include/* /usr/include/

WORKDIR /tmp/libsaxon/php/src
# Build Saxon
RUN export "LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/lib" \
  && phpize \
  && autoupdate \
  && ./configure \
  && make -j$(nproc) \
  && make test \
  && make install

# Prepare files
RUN mkdir -p /tmp/extensions /tmp/conf.d /tmp/lib64
RUN cp "$(php-config --extension-dir)/saxon.so" /tmp/extensions/saxonc.so
RUN echo "extension=/opt/php/extensions/saxonc.so" >> /tmp/conf.d/ext-saxonc.ini
RUN cp /usr/lib/libsaxonc-* /tmp/lib64/

# The definitive build
FROM scratch
COPY --from=ext /tmp/conf.d/ /opt/php/conf.d/
COPY --from=ext /tmp/extensions/ /opt/php/extensions/
COPY --from=ext /tmp/lib64/ /opt/php/lib64/
