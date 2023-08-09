FROM debian as ext

RUN apt update \
    && apt install -y curl tar wget build-essential libreadline-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev

RUN mkdir -p /opt/share/python /opt/bin

# https://www.openssl.org/source/
ARG OPENSSL_VERSION=1.1.1v
RUN curl -sS -o openssl.tar.gz "https://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz" \
    && tar -xzf openssl.tar.gz

RUN cd openssl-$OPENSSL_VERSION \
    && ./config --prefix=/opt/share --openssldir=/opt/share/openssl \
    && make -j$(nproc) \
    && make install

# https://www.python.org/downloads/
ARG VERSION=3.11.4
RUN curl -sS -o python.tgz "https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tgz" \
    && tar -xzf python.tgz

RUN cd Python-$VERSION \
    && echo "_ssl _ssl.c $(OPENSSL_INCLUDES) $(OPENSSL_LDFLAGS) -l:libssl.a -Wl,--exclude-libs,libssl.a -l:libcrypto.a -Wl,--exclude-libs,libcrypto.a" >> Modules/Setup \
    && echo "_hashlib _hashopenssl.c $(OPENSSL_INCLUDES) $(OPENSSL_LDFLAGS) -l:libcrypto.a -Wl,--exclude-libs,libcrypto.a" >> Modules/Setup

RUN cd Python-$VERSION \
    && export LDFLAGS="-L/opt/share/lib/" \
    && export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:-L/opt/share/lib/" \
    && export CPPFLAGS="-I/opt/share/include -I/opt/share/include/openssl" \
    && ./configure --enable-optimizations --with-lto --with-ssl --prefix=/opt/share \
    && make -j$(nproc) \
    && make install

RUN ln -s /opt/share/bin/pydoc3 /opt/bin/pydoc3 \
    && ln -s /opt/share/bin/python3 /opt/bin/python3 \
    && ln -s /opt/share/bin/pip3 /opt/bin/pip3 \
    && ln -s pydoc3 /opt/bin/pydoc \
    && ln -s python3 /opt/bin/python \
    && ln -s pip3 /opt/bin/pip

# The definitive build
FROM scratch
COPY --from=ext /opt/share/ /opt/share/
COPY --from=ext /opt/bin/ /opt/bin/
