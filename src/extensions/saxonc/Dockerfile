ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} AS ext

# BuildKit target architecture
ARG TARGETARCH

ENV SAXONC_HOME=/opt/php/lib64

# Resolve the latest release within the SaxonC major version for this PHP runtime.
RUN set -eux; \
  if [ "$(php -r 'echo PHP_VERSION_ID;')" -lt 80600 ]; then SAXON_MAJOR=12; else SAXON_MAJOR=13; fi; \
  case "${TARGETARCH}" in \
    amd64) SAXON_ARCH=x86_64 ;; \
    arm64) SAXON_ARCH=arm64 ;; \
    *) echo "Unsupported SaxonC architecture: ${TARGETARCH}" >&2; exit 1 ;; \
  esac; \
  curl -fLsS https://www.saxonica.com/html/download/c.html -o /tmp/saxon-downloads.html; \
  DOWNLOAD_URL="$(grep -oE "https://downloads\.saxonica\.com/SaxonC/HE/${SAXON_MAJOR}/SaxonCHE-linux-${SAXON_ARCH}-${SAXON_MAJOR}-[0-9]+-[0-9]+\.zip" /tmp/saxon-downloads.html | sort -Vu | tail -n 1)"; \
  test -n "$DOWNLOAD_URL"; \
  echo "Downloading SaxonC: $DOWNLOAD_URL"; \
  curl -fLsS -o /tmp/libsaxon-setup.zip "$DOWNLOAD_URL"; \
  unzip /tmp/libsaxon-setup.zip -d "/tmp/libsaxon"; \
  mv /tmp/libsaxon/*/* /tmp/libsaxon

WORKDIR /tmp/libsaxon

# Copy required files
RUN set -eux; \
  cp -r SaxonCHE/lib/. SaxonCCoreHE/lib/. /usr/lib/; \
  cp -r SaxonCHE/include/. SaxonCCoreHE/include/. /usr/include/

WORKDIR /tmp/libsaxon/php/src
# Build Saxon
RUN set -eux; \
  export "LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/lib"; \
  phpize; \
  autoupdate; \
  ./configure --with-saxonc=/usr --with-saxonc-core=/usr; \
  make -j$(nproc); \
  make test; \
  make install

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
