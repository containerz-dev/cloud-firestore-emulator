# syntax=docker/dockerfile-upstream:master-labs

FROM --platform=$BUILDPLATFORM cgr.dev/chainguard/jdk:latest-dev AS cloud-firestore-emulator
ARG TARGETPLATFORM

ARG FIRESTORE_EMULATOR_BUILD_NUMBER
LABEL org.opencontainers.image.authors="The containerz authors"
LABEL org.opencontainers.image.url="https://github.com/containerz-dev/cloud-firestore-emulator"
LABEL org.opencontainers.image.source="https://github.com/containerz-dev/cloud-firestore-emulator"
LABEL org.opencontainers.image.documentation="Cloud SDK less cloud firestore emulator container image"
LABEL org.opencontainers.image.base.name="cgr.dev/chainguard/jdk:latest-dev"
LABEL org.opencontainers.image.version="${FIRESTORE_EMULATOR_BUILD_NUMBER}"
LABEL org.opencontainers.image.licenses="BSD-3-Clause"

ENV FIRESTORE_EMULATOR_URL="https://dl.google.com/dl/cloudsdk/channels/rapid/components/google-cloud-sdk-cloud-firestore-emulator-${FIRESTORE_EMULATOR_BUILD_NUMBER}.tar.gz"
ADD --chown=java:java ${FIRESTORE_EMULATOR_URL} /home/build
RUN tar xfz /home/build/google-cloud-sdk-cloud-firestore-emulator-${FIRESTORE_EMULATOR_BUILD_NUMBER}.tar.gz --strip-components=1 -C /home/build && \
  rm -f /home/build/google-cloud-sdk-cloud-firestore-emulator-${FIRESTORE_EMULATOR_BUILD_NUMBER}.tar.gz

EXPOSE 8080/tcp
ENTRYPOINT ["/home/build/cloud-firestore-emulator/cloud_firestore_emulator", "--host=0.0.0.0", "--port=8080"]
