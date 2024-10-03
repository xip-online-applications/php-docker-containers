ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} AS ext

ARG LIBSAXON_VERSION=1.2.1
ARG LIBSAXON_ARCHITECTURE=64
ARG LIBSAXON_DOWNLOAD_FILE_NAME=libsaxon-HEC-setup$LIBSAXON_ARCHITECTURE-v$LIBSAXON_VERSION

ENV SAXONC_HOME=/opt/php/lib64

# Download saxon lib
RUN curl --insecure -LsS -o /libsaxon-setup.zip https://www.saxonica.com/saxon-c/$LIBSAXON_DOWNLOAD_FILE_NAME.zip \
  && unzip /libsaxon-setup.zip \
  && rm /libsaxon-setup.zip

# Prepare saxon installation
COPY install-libsaxon-setup.sh /install-libsaxon-setup.sh
RUN chmod u+x /install-libsaxon-setup.sh \
  && . /install-libsaxon-setup.sh \
  && cp /Saxon-HEC$LIBSAXON_VERSION/libsaxonhec.so /usr/lib/. \
  && cp -r /Saxon-HEC$LIBSAXON_VERSION/rt /usr/lib/. \
  && cp -r /Saxon-HEC$LIBSAXON_VERSION/saxon-data /usr/lib/.

# Build saxon
RUN cd /Saxon-HEC$LIBSAXON_VERSION/Saxon.C.API \
  && phpize \
  && ./configure --enable-saxon \
  && make -j$(nproc) \
  && make install

# Prepare files
RUN mkdir -p /tmp/extensions /tmp/conf.d /tmp/lib64
RUN cp "$(php-config --extension-dir)/saxon.so" /tmp/extensions/saxonc.so
RUN echo "extension=/opt/php/extensions/saxonc.so" >> /tmp/conf.d/ext-saxonc.ini
RUN cp /usr/lib/libsaxonhec.so /tmp/lib64/libsaxonhec.so
RUN cp -r /usr/lib/rt /tmp/lib64/rt
RUN cp -r /usr/lib/saxon-data /tmp/lib64/saxon-data

# The definitive build
FROM scratch
COPY --from=ext /tmp/conf.d/ /opt/php/conf.d/
COPY --from=ext /tmp/extensions/ /opt/php/extensions/
COPY --from=ext /tmp/lib64/ /opt/php/lib64/
