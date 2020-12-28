# Ethereum CUDA Miner (*DO NOT USE*)
[![](https://images.microbadger.com/badges/image/fish2/docker-ethminer.svg)](https://microbadger.com/images/fish2/docker-ethminer "Get your own image badge on microbadger.com")

### Docker container for Ethereum mining with CUDA.

Simple and easy to run, if you have a Nvidia GPU and want to mine eth.

This image pulls https://github.com/ethereum-mining/ethminer/releases unpacks it, and makes it ready to use in nvidia-docker.

### Requirements
- Nvidia drivers (I also needed cuda) for your GPU, you can get them here: [Nvidia drivers](http://www.nvidia.com/Download/index.aspx)
- Nvidia-docker (so docker can access your GPU) install instructions here: [nvidia-docker](https://github.com/NVIDIA/nvidia-docker)

### How to run using nvidia-docker 2.x
```
$ docker run --runtime=nvidia --rm -it jerry3k/docker-ethminer ARG1 ARG2 ...

# Example
docker run --runtime=nvidia --rm -it jerry3k/docker-ethminer -P stratum1+tcp://0x50210a4a578d10346ead3a770e888ca749a4bccb@eth-eu1.nanopool.org:9999/tag-a10/jerry3k@hotmail.com
```

**Note:** `-U` is set by default

**Note:** Be sure to change the -O argument to your mining address and email. The format goes like this "address.worker/email"

### Help
```
docker run --rm --runtime=nvidia fish2/docker-ethminer --help
```
