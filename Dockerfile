# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    curl \
    iptables \
    build-essential \
    git \
    wget \
    lz4 \
    jq \
    make \
    gcc \
    nano \
    automake \
    autoconf \
    tmux \
    htop \
    nvme-cli \
    libgbm1 \
    pkg-config \
    libssl-dev \
    libleveldb-dev \
    tar \
    clang \
    bsdmainutils \
    gnupg \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Expose required ports
EXPOSE 40400 8080

# Copy and set entry script
COPY entry.sh /entry.sh
RUN chmod +x /entry.sh

ENTRYPOINT ["/entry.sh"]
