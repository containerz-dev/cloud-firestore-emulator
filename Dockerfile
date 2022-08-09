# syntax=docker/dockerfile-upstream:1.4

ARG OPENJDK_TAG
FROM adoptopenjdk/openjdk11:${OPENJDK_TAG} AS cloud-firestore-emulator

ARG FIRESTORE_EMULATOR_BUILD_NUMBER
ENV FIRESTORE_EMULATOR_URL="https://dl.google.com/dl/cloudsdk/channels/rapid/components/google-cloud-sdk-cloud-firestore-emulator-${FIRESTORE_EMULATOR_BUILD_NUMBER}.tar.gz"
RUN set -eux; \
	apk --no-cache add \
		bash; \
	\
	wget -q -O- ${FIRESTORE_EMULATOR_URL} | tar xfz - --strip-components=1 -C /

EXPOSE 8080/tcp
ENTRYPOINT ["/cloud-firestore-emulator/cloud_firestore_emulator"]

LABEL org.opencontainers.image.authors       "The containerz authors"
LABEL org.opencontainers.image.url           "https://github.com/containerz-dev/cloud-firestore-emulator"
LABEL org.opencontainers.image.source        "https://github.com/containerz-dev/cloud-firestore-emulator/Dockerfile"
LABEL org.opencontainers.image.documentation "Cloud SDK less cloud firestore emulator container image"
LABEL org.opencontainers.image.base.name     "adoptopenjdk/openjdk11:${OPENJDK_TAG}"
LABEL org.opencontainers.image.version       "${FIRESTORE_EMULATOR_BUILD_NUMBER}"
LABEL org.opencontainers.image.licenses      "BSD-3-Clause"
