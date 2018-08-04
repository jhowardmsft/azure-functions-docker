ARG NAMESPACE=microsoft
ARG IMAGE_TAG=dev-nightly
FROM ${NAMESPACE}/azure-functions-base:${IMAGE_TAG}

RUN apt-get update && \
    apt-get install -y gnupg && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get update && \
    apt-get install -y nodejs