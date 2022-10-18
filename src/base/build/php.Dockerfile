ARG VERSION

FROM xiponlineapplications/php-build:${VERSION}

ENV TM_PHP_BIN_DIR=/opt/bin
ENV TM_PHP_CONF_DIR=/opt/php/conf.d
ENV TM_PHP_EXTENSION_DIR=/opt/php/extensions
ENV TM_PHP_LIB_DIR=/opt/php/lib64

ENV PHP_INI_SCAN_DIR=/usr/local/etc/php/conf.d:$TM_PHP_CONF_DIR
ENV PATH=$PATH:$TM_PHP_BIN_DIR
ENV LD_LIBRARY_PATH=$TM_PHP_LIB_DIR

RUN echo $TM_PHP_LIB_DIR >> /etc/ld.so.conf.d/php.conf

RUN mkdir -p \
    $TM_PHP_BIN_DIR \
    $TM_PHP_CONF_DIR \
    $TM_PHP_EXTENSION_DIR \
    $TM_PHP_LIB_DIR

RUN apt-get update && apt-get install -y \
  git zip unzip openssl

COPY php.ini /usr/local/etc/php/php.ini
