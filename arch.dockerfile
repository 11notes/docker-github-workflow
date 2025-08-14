# :: Header
  FROM scratch

  # :: arguments
    ARG TARGETARCH
    ARG APP_VERSION

  # :: multi-stage
    ADD alpine-minirootfs-${APP_VERSION}-${TARGETARCH}.tar.gz /