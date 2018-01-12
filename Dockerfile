FROM nvidia/cuda:9.1-runtime-ubuntu16.04

# set maintainer label
LABEL maintainer="fish2"

WORKDIR /root

# Env setup
ENV ETH_VER=0.13.0rc5
ENV GPU_FORCE_64BIT_PTR=0
ENV GPU_MAX_HEAP_SIZE=100
ENV GPU_USE_SYNC_OBJECTS=1
ENV GPU_MAX_ALLOC_PERCENT=100
ENV GPU_SINGLE_ALLOC_PERCENT=100
ENV ETH_DOWNLOAD_URL=https://github.com/ethereum-mining/ethminer/releases/download/v$ETH_VER/ethminer-$ETH_VER-Linux.tar.gz

RUN apt-get update && \

DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \

DEBIAN_FRONTEND=noninteractive apt-get install -y \
    apt-utils \
    ca-certificates \
    curl && \

curl -L "$ETH_DOWNLOAD_URL" -o ethminer.tar.gz && \

tar -xf ethminer.tar.gz -C /usr/local && \

# Clean Up
apt-get remove --purge -y curl && apt-get autoremove -y && apt-get clean && \

rm -rf ethminer.tar.gz /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["/usr/local/bin/ethminer", "-U"]
