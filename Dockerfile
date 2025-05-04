FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl iptables build-essential git wget lz4 jq make gcc nano automake autoconf \
    tmux htop nvme-cli libgbm1 pkg-config libssl-dev libleveldb-dev tar \
    clang bsdmainutils ncdu unzip libleveldb-dev ufw screen \
    && rm -rf /var/lib/apt/lists/*

# Set up Aztec CLI path even if not installed yet (will be installed later in entrypoint)
ENV PATH="/root/.aztec/bin:${PATH}"

# Allow ports
RUN ufw allow 40400 && \
    ufw allow 8080 && \
    ufw --force enable

# Copy startup script
COPY entry.sh /entry.sh
RUN chmod +x /entry.sh

EXPOSE 40400 8080

ENTRYPOINT ["/entry.sh"]
