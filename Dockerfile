FROM nvidia/cuda:8.0-devel-ubuntu16.04

MAINTAINER John Goodwin <john@jjgoodwin.com>

WORKDIR /

# Package and dependency setup
RUN apt-get update \
    && apt-get -y install software-properties-common \
    && add-apt-repository -y ppa:ethereum/ethereum -y \
    && apt-get update \
    && apt-get install -y git \
        cmake \
        libcryptopp-dev \
        libleveldb-dev \
        libjsoncpp-dev \
        libjsonrpccpp-dev \
        libboost-all-dev \
        libgmp-dev \
        libreadline-dev \
        libcurl4-gnutls-dev \
        ocl-icd-libopencl1 \
        opencl-headers \
        mesa-common-dev \
        libmicrohttpd-dev \
        build-essential \
    # Git repo set up
    && git clone https://github.com/ethereum-mining/ethminer.git; \
    cd ethminer; \
    git checkout tags/v0.12.0 \
    # Build
    && mkdir build; \
    cd build; \
    cmake .. -DETHASHCUDA=ON -DETHASHCL=OFF -DETHSTRATUM=ON; \
    cmake --build .; \
    make install \
    && apt-get -yq purge git \
        cmake \
        libcryptopp-dev \
        libleveldb-dev \
        libjsoncpp-dev \
        libjsonrpccpp-dev \
        libboost-all-dev \
        libgmp-dev \
        libreadline-dev \
        libcurl4-gnutls-dev \
        ocl-icd-libopencl1 \
        opencl-headers \
        mesa-common-dev \
        libmicrohttpd-dev \
        build-essential \
    && apt-get -yq autoclean \
    && apt-get -yq autoremove \
    && apt-get -yq clean \

# Env setup
ENV GPU_FORCE_64BIT_PTR=0
ENV GPU_MAX_HEAP_SIZE=100
ENV GPU_USE_SYNC_OBJECTS=1
ENV GPU_MAX_ALLOC_PERCENT=100
ENV GPU_SINGLE_ALLOC_PERCENT=100

ENTRYPOINT ["/usr/local/bin/ethminer", "-U"]
