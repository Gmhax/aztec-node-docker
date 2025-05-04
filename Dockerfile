# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
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
    && rm -rf /var/lib/apt/lists/*

# Install Docker (for container setup)
RUN install -m 0755 -d /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
    && chmod a+r /etc/apt/keyrings/docker.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt-get update \
    && apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Expose required ports for the node (these are for the host machine)
EXPOSE 40400 8080

# Copy entry script
COPY entry.sh /entry.sh
RUN chmod +x /entry.sh

# Set the entry point to run the node
ENTRYPOINT ["/entry.sh"]
