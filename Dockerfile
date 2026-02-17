FROM ubuntu:24.04

# Install build dependencies
RUN apt-get update && apt-get install -y \
    capnproto \
    libcapnp-dev \
    build-essential \
    cmake \
    libtool \
    autotools-dev \
    automake \
    pkg-config \
    bsdmainutils \
    curl \
    git \
    ca-certificates \
    libevent-dev \
    libboost-system-dev \
    libboost-filesystem-dev \
    libboost-test-dev \
    libboost-thread-dev \
    libminiupnpc-dev \
    libzmq3-dev \
    libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy source code
COPY . /bitcoin

WORKDIR /bitcoin

# Build using CMake
RUN cmake -S . -B build \
    -DENABLE_ZMQ=OFF \
    -DENABLE_QT=OFF \
    -DENABLE_WALLET=OFF \
    -DBUILD_BITCOIN_CLI=OFF \
    -DBUILD_BITCOIN_TX=OFF \
    -DBUILD_TESTING=OFF \
    && cmake --build build --parallel \
    && cmake --install build
