# syntax=docker/dockerfile-upstream:1.5

FROM --platform=${BUILDPLATFORM} cgr.dev/chainguard/jre:openjdk-jre-11 AS cloud-firestore-emulator

ARG FIRESTORE_EMULATOR_BUILD_NUMBER
LABEL org.opencontainers.image.authors       "The containerz authors"
LABEL org.opencontainers.image.url           "https://github.com/containerz-dev/cloud-firestore-emulator"
LABEL org.opencontainers.image.source        "https://github.com/containerz-dev/cloud-firestore-emulator"
LABEL org.opencontainers.image.documentation "Cloud SDK less Cloud Firestore Emulator container image"
LABEL org.opencontainers.image.base.name     "cgr.dev/chainguard/jre:openjdk-jre-11"
LABEL org.opencontainers.image.version       "${FIRESTORE_EMULATOR_BUILD_NUMBER}"
LABEL org.opencontainers.image.licenses      "BSD-3-Clause"

ENV FIRESTORE_EMULATOR_URL="https://dl.google.com/dl/cloudsdk/channels/rapid/components/google-cloud-sdk-cloud-firestore-emulator-${FIRESTORE_EMULATOR_BUILD_NUMBER}.tar.gz"
RUN wget -O - -qq ${FIRESTORE_EMULATOR_URL} | tar xfz - --strip-components=1 -C /

EXPOSE 8080/tcp
ENTRYPOINT ["/cloud-firestore-emulator/cloud_firestore_emulator", "--host", "0.0.0.0"]
