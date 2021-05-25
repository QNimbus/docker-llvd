ARG ALPINE_VERSION=3.12

FROM alpine:${ALPINE_VERSION}

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION=latest
LABEL \
    org.opencontainers.image.authors="bas@vanwetten.com" \
    org.opencontainers.image.created=$BUILD_DATE \
    org.opencontainers.image.revision=$VCS_REF \
    org.opencontainers.image.version="${VERSION}" \
    org.opencontainers.image.url="https://github.com/qnimbus/docker-llvd" \
    org.opencontainers.image.documentation="https://github.com/qnimbus/docker-llvd/blob/master/README.md" \
    org.opencontainers.image.source="https://github.com/qnimbus/docker-llvd" \
    org.opencontainers.image.title="docker-llvd" \
    org.opencontainers.image.description="Download with llvd using command line arguments or configuration files"
HEALTHCHECK --interval=10m --timeout=10s --retries=1 CMD [ "$(wget -qO- https://duckduckgo.com 2>/dev/null)" != "" ] || exit 1

ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 \
    LANGUAGE=en_US:en \
    LOG=yes \
    VERSION=$VERSION

RUN apk add --no-cache bash

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apk add -q --progress --update --no-cache \
        ca-certificates \
        ffmpeg \
        python3 \
        py3-pip \
        su-exec

RUN apk add -q --progress --update --no-cache --virtual deps \
        wget \
        gnupg
    
RUN pip install --no-cache-dir llvd==2.2.5

COPY init /init

RUN apk del deps && \
    rm -rf /var/cache/apk/* && \
    chmod +x /init

WORKDIR /downloads
ENTRYPOINT ["/init"]
CMD ["--help"]
