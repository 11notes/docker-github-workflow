# ╔═════════════════════════════════════════════════════╗
# ║                       SETUP                         ║
# ╚═════════════════════════════════════════════════════╝
# GLOBAL
  ARG APP_UID=1000 \
      APP_GID=1000

# :: FOREIGN IMAGES
  FROM 11notes/util AS util
  FROM 11notes/distroless AS distroless
  FROM 11notes/distroless:curl AS distroless-curl
  FROM 11notes/distroless:tini AS distroless-tini
  FROM 11notes/distroless:upx AS distroless-upx


# ╔═════════════════════════════════════════════════════╗
# ║                       BUILD                         ║
# ╚═════════════════════════════════════════════════════╝
# :: FILE-SYSTEM
  FROM scratch AS build
  ARG TARGETPLATFORM \
      TARGETOS \
      TARGETARCH \
      TARGETVARIANT \
      APP_IMAGE \
      APP_NAME \
      APP_VERSION \
      APP_ROOT \
      APP_UID \
      APP_GID \
      APP_NO_CACHE

  ADD rootfs-${APP_VERSION}-${TARGETARCH}${TARGETVARIANT}.tar.gz /

  COPY --from=util / /
  COPY ./rootfs /
  COPY --from=distroless / /
  COPY --from=distroless-curl / /
  COPY --from=distroless-tini / /
  COPY --from=distroless-upx / /

  RUN set -ex; \
    chmod +x -R /usr/local/bin;

  RUN set -ex; \
    find / -type f -executable -exec eleven shrink {} ';';

  RUN set -ex; \
    for FOLDER in /tmp/* /root/*; do \
      rm -rf ${FOLDER}; \
    done; \
    rm -rf /usr/local/bin/upx;


# ╔═════════════════════════════════════════════════════╗
# ║                       IMAGE                         ║
# ╚═════════════════════════════════════════════════════╝
# :: HEADER
  FROM scratch

  # :: default arguments
    ARG TARGETPLATFORM \
        TARGETOS \
        TARGETARCH \
        TARGETVARIANT \
        APP_IMAGE \
        APP_NAME \
        APP_VERSION \
        APP_ROOT \
        APP_UID \
        APP_GID \
        APP_NO_CACHE
        
  # :: app specific environment
    ENV DEBIAN_FRONTEND=noninteractive

  # :: multi-stage
    COPY --from=build / /

# :: EXECUTE
  USER ${APP_UID}:${APP_GID}
  ENTRYPOINT ["/usr/local/bin/tini", "--", "/usr/local/bin/entrypoint.sh"]