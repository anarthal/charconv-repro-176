FROM alpine:3.18.2

WORKDIR /boost-source

RUN apk update && apk add --no-cache \
    g++ \
    cmake \
    ninja \
    openssl-dev \
    icu-dev \
    git \
    linux-headers \
    wget \
    libquadmath \
    vim

RUN wget https://boostorg.jfrog.io/artifactory/main/beta/1.85.0.beta1/source/boost_1_85_0_b1.tar.gz

RUN tar -xf boost_1_85_0_b1.tar.gz \
    && cd boost_1_85_0 \
    && ./bootstrap.sh \
    && ./b2 --with-charconv --prefix=/opt/boost install

COPY repro /repro

RUN cd /repro && \
    mkdir __build && \
    cd __build && \
    cmake -DCMAKE_PREFIX_PATH=/opt/boost -G Ninja .. && \
    ninja -v
