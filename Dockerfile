FROM node:9.6.1-alpine

COPY entrypoints /entrypoints
COPY . /app/

RUN echo @edge http://uk.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
    apk update && \
    apk add --no-cache \
    bash \
    openjdk8-jre-base \
    nss@edge \
    chromium-chromedriver@edge \
    chromium@edge

ENV CHROME_BIN /usr/bin/chromium-browser
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH=$PATH:/home/node/.npm-global/bin

ONBUILD ARG TARGET=release
ONBUILD ARG SPECS_FOLDER=e2e
ONBUILD ENV SPECS_FOLDER=$SPECS_FOLDER
ONBUILD ARG PROTRACTOR_CONFIG_FILE=protractor.conf.js
ONBUILD ENV PROTRACTOR_CONFIG_FILE $PROTRACTOR_CONFIG_FILE
ONBUILD WORKDIR /app

ONBUILD COPY ${SPECS_FOLDER} /app/e2e
ONBUILD RUN \
  cp /entrypoints/${TARGET}.sh /entrypoint.sh && \
  chmod +x /entrypoint.sh && \
  chown -R node /app

ONBUILD USER node
ONBUILD RUN npm install

ENTRYPOINT ["/entrypoint.sh"]