FROM debian:oldstable AS ext

ARG OPENSSL_VERSION=3.1.7
ARG VERSION=3.12.7

RUN apt update && \
    apt install -y build-essential curl \
    libbz2-dev libc6-dev libffi-dev libgdbm-dev \
    libncursesw5-dev libreadline-dev libsqlite3-dev \
    libssl-dev tar tk-dev wget zlib1g-dev && \
    apt-get clean && \
    mkdir -p /opt/share/python /opt/bin && \
    curl -o openssl.tar.gz https://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz && \
    tar -xzf openssl.tar.gz && \
    cd openssl-$OPENSSL_VERSION && \
    ./config --prefix=/opt/share --openssldir=/opt/share/openssl && \
    make -j$(nproc) && \
    make install && \
    curl -sS -o python.tgz "https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tgz" && \
    tar -xzf python.tgz && \
    cd Python-"$VERSION" && \
    echo "_ssl _ssl.c $(OPENSSL_INCLUDES) $(OPENSSL_LDFLAGS) -l:libssl.a -Wl,--exclude-libs,libssl.a -l:libcrypto.a -Wl,--exclude-libs,libcrypto.a" >> Modules/Setup && \
    echo "_hashlib _hashopenssl.c $(OPENSSL_INCLUDES) $(OPENSSL_LDFLAGS) -l:libcrypto.a -Wl,--exclude-libs,libcrypto.a" >> Modules/Setup && \
    cd Python-"$VERSION" && \
    export LDFLAGS="-L/opt/share/lib/ -L/opt/share/lib64/" && \
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:-L/opt/share/lib/:-L/opt/share/lib64/" && \
    export CPPFLAGS="-I/opt/share/include -I/opt/share/include/openssl" && \
    ./configure --enable-optimizations --with-lto --with-ssl --prefix=/opt/share && \
    make -j$(nproc) && \
    make install && \
    ln -s /opt/share/bin/pydoc3 /opt/bin/pydoc3 && \
    ln -s /opt/share/bin/python3 /opt/bin/python3 && \
    ln -s /opt/share/bin/pip3 /opt/bin/pip3 && \
    ln -s pydoc3 /opt/bin/pydoc && \
    ln -s python3 /opt/bin/python && \
    ln -s pip3 /opt/bin/pip

# The definitive build
FROM scratch
COPY --from=ext /opt/share/ /opt/share/
COPY --from=ext /opt/bin/ /opt/bin/
