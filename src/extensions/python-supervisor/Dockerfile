ARG REPO
ARG PHP_VERSION
ARG REPO_PYTHON

FROM $REPO_PYTHON AS base

FROM debian:bullseye AS ext

COPY --from=base /opt /opt

RUN /opt/bin/pip3 install supervisor

RUN mkdir -p /tmp/bin \
    && cp /opt/share/bin/supervisor* /tmp/bin/
RUN PYTHON_PATH=/opt/share \
    && PYTHON_PACKAGE=$(find $PYTHON_PATH/lib -name site-packages) \
    && TEMP_PACKAGE=$(echo $PYTHON_PACKAGE | sed "s|${PYTHON_PATH}|/tmp/supervisor|") \
    && mkdir -p $TEMP_PACKAGE \
    && cp -r $PYTHON_PACKAGE/supervisor* $TEMP_PACKAGE/

# The definitive build
FROM scratch
COPY --from=ext /tmp/bin/ /opt/bin/
COPY --from=ext /tmp/supervisor/ /opt/share/
