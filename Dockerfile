FROM rust:1.56.1-alpine3.14

ARG NODE_VERSION=14.18.1-r0
ARG WASM_PACK_VERSION=0.10.1

RUN apk add --no-cache \
      nodejs=${NODE_VERSION} \
      npm \
      zlib \
      musl-dev \
      openssl \
      openssl-dev \
      perl \
      make \
    && cargo install wasm-pack --version=${WASM_PACK_VERSION} \
    && rustup target add wasm32-unknown-unknown \
    && chmod -R 777 /usr/local/cargo/registry

ENV USER=wasm-pack

RUN adduser --uid 1000 --disabled-password "${USER}"

WORKDIR /work
USER wasm-pack
ENTRYPOINT ["wasm-pack"]
