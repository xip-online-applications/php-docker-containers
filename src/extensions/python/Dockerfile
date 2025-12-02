FROM debian:oldstable AS ext

RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libncurses5-dev \
    libreadline-dev \
    libgdbm-dev \
    libdb5.3-dev \
    libbz2-dev \
    libsqlite3-dev \
    libffi-dev \
    tk-dev \
    liblzma-dev \
    && apt-get clean

RUN mkdir -p /opt/share/python /opt/bin

# Choose latest security version:
# https://www.python.org/downloads/
# Also adjust in Makefile and python-supervisor/Makefile
ARG VERSION=3.12.12

RUN curl -sS -o python.tgz "https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tgz" \
  && tar -xzf python.tgz \
  && cd Python-$VERSION \
  && ./configure \
    --enable-optimizations \
    --with-lto \
    --prefix=/opt \
    --with-ensurepip=install \
  && make -j$(nproc) \
  && make install

RUN ln -s /opt/bin/python3 /opt/bin/python3 \
  && ln -s /opt/bin/python3 /opt/bin/python \
  && ln -s /opt/bin/pip3 /opt/bin/pip3 \
  && ln -s /opt/bin/pip3 /opt/bin/pip \
  && ln -s /opt/bin/pydoc3 /opt/bin/pydoc \
  && ln -s /opt/bin/pydoc3 /opt/bin/pydoc3

FROM scratch
COPY --from=ext /opt/ /opt/
