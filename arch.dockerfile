# :: Util
  FROM alpine as util

  RUN set -ex; \
    apk add --no-cache \
      git; \
    git clone -b stable https://github.com/11notes/docker-util.git;

# :: Build / mimalloc
  FROM alpine as mimalloc
  ARG MIMALLOC_VERSION=v2.1.7

  RUN set -ex; \
    apk add --no-cache \
      curl \
      wget \
      unzip \
      build-base \
      linux-headers \
      make \
      cmake \
      g++ \
      git; \
    git clone https://github.com/microsoft/mimalloc.git -b ${MIMALLOC_VERSION}; \
    cd /mimalloc; \
    mkdir build; \
    cd build; \
    cmake ..; \
    make -j$(nproc); \
    make install;  

# :: Header
  FROM scratch

  # :: arguments
    ARG TARGETARCH
    ARG APP_VERSION
    ARG APP_NAME

  # :: environment
    ENV APP_VERSION=${APP_VERSION}
    ENV APP_NAME=${APP_NAME}
    ENV LD_PRELOAD=/lib/libmimalloc.so
    ENV MIMALLOC_LARGE_OS_PAGES=1

  # :: multi-stage
    ADD alpine-minirootfs-${APP_VERSION}-${TARGETARCH}.tar.gz /
    COPY --from=util /docker-util/src /usr/local/bin
    COPY --from=mimalloc /mimalloc/build/*.so.* /lib/

# :: Run
  USER root

  # :: update image
    RUN set -ex; \
      apk --no-cache --update add \
        ca-certificates \
        tini \
        curl \
        tzdata \
        shadow; \
      apk --no-cache --update upgrade;

  # :: create user
    RUN set -ex; \
      addgroup --gid 1000 -S docker; \
      adduser --uid 1000 -D -S -h / -s /sbin/nologin -G docker docker;

  # :: copy root filesystem changes and set correct permissions
    COPY ./rootfs /
    RUN set -ex; \
      chmod +x -R /usr/local/bin; \
      chown -R 1000:1000 /usr/local/bin;

# :: Start
  USER docker
  ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/entrypoint.sh"]