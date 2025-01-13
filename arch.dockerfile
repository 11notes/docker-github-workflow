# :: Image
  FROM scratch
  ARG ARCH=
  ARG APP_VERSION=
  ADD alpine-minirootfs-${APP_VERSION}-${ARCH}.tar.gz /

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