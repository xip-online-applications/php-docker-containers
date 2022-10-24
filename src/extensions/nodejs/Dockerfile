ARG NODEJS_VERSION
FROM node:$NODEJS_VERSION as node

FROM debian as ext

ENV PATH=$PATH:/opt/bin

RUN mkdir -p /opt/bin /opt/lib

COPY --from=node /usr/local/bin/node /opt/bin/
COPY --from=node /usr/local/lib/node_modules /opt/lib/node_modules

RUN ln -s /opt/bin/node /opt/bin/nodejs
RUN ln -s ../lib/node_modules/npm/bin/npm-cli.js /opt/bin/npm
RUN ln -s ../lib/node_modules/npm/bin/npx-cli.js /opt/bin/npx
RUN ln -s ../lib/node_modules/corepack/dist/corepack.js /opt/bin/corepack

FROM scratch
COPY --from=ext /opt /opt
