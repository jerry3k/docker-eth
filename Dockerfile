FROM nvidia/cuda:10.0-runtime-ubuntu18.04

# set maintainer label
LABEL maintainer="fish2"

WORKDIR /root

# Env setup
ENV ETH_VER=0.16.1
ENV GPU_FORCE_64BIT_PTR=0
ENV GPU_MAX_HEAP_SIZE=100
ENV GPU_USE_SYNC_OBJECTS=1
ENV GPU_MAX_ALLOC_PERCENT=100
ENV GPU_SINGLE_ALLOC_PERCENT=100
ENV ETH_DOWNLOAD_URL=https://github.com/ethereum-mining/ethminer/releases/download/v$ETH_VER/ethminer-$ETH_VER-linux-x86_64.tar.gz

RUN apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
DEBIAN_FRONTEND=noninteractive apt-get install -y \
    apt-utils \
    ca-certificates \
    curl && \
curl -L "$ETH_DOWNLOAD_URL" -o /tmp/ethminer.tar.gz && \
tar -xf /tmp/ethminer.tar.gz -C /usr/local && \
apt-get remove --purge -y curl && apt-get autoremove -y && apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["/usr/local/bin/ethminer", "-U"]
