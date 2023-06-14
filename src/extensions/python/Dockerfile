FROM debian as ext

RUN apt update \
    && apt install -y curl tar wget build-essential libreadline-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev

RUN mkdir -p /opt/share/python /opt/bin

# https://www.python.org/downloads/
ARG VERSION=3.11.4
RUN curl -sS -o python.tgz "https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tgz" \
    && tar -xzf python.tgz \
    && cd Python-$VERSION \
    && ./configure --enable-optimizations --prefix=/opt/share/python \
    && make -j$(nproc) \
    && make install

RUN ln -s /opt/share/python/bin/python3 /opt/bin/python3 \
    && ln -s /opt/share/python/bin/pip3 /opt/bin/pip3 \
    && ln -s python3 /opt/bin/python \
    && ln -s pip3 /opt/bin/pip

# The definitive build
FROM scratch
COPY --from=ext /opt/share/ /opt/share/
COPY --from=ext /opt/bin/ /opt/bin/
