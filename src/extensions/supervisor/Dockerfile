ARG REPO
ARG PHP_VERSION
ARG REPO_PYTHON

FROM $REPO_PYTHON as base

FROM ${REPO}:${PHP_VERSION} as ext

COPY --from=base /opt /opt

RUN pip install supervisor

RUN mkdir -p /tmp/bin \
    && cp /opt/share/python/bin/supervisor* /tmp/bin/
RUN PYTHON_PATH=/opt/share/python \
    && PYTHON_PACKAGE=$(find $PYTHON_PATH/lib -name site-packages) \
    && TEMP_PACKAGE=$(echo $PYTHON_PACKAGE | sed "s|${PYTHON_PATH}|/tmp/supervisor|") \
    && mkdir -p $TEMP_PACKAGE \
    && cp -r $PYTHON_PACKAGE/supervisor* $TEMP_PACKAGE/

# The definitive build
FROM scratch
COPY --from=ext /tmp/bin/ /opt/bin/
COPY --from=ext /tmp/supervisor/ /opt/share/python/
