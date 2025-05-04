FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl iptables build-essential git wget lz4 jq make gcc nano automake autoconf \
    tmux htop nvme-cli libgbm1 pkg-config libssl-dev libleveldb-dev tar \
    clang bsdmainutils ncdu unzip ca-certificates gnupg \
    software-properties-common screen ufw \
    && rm -rf /var/lib/apt/lists/*

# Install Docker inside container
RUN install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    chmod a+r /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) stable" \
    | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Install Aztec CLI tools
RUN curl -s https://install.aztec.network | bash

# Add Aztec CLI to PATH
ENV PATH="/root/.aztec/bin:${PATH}"

# Enable UFW and open ports
RUN ufw allow 40400 && \
    ufw allow 8080 && \
    ufw --force enable

# Copy entry script
COPY entry.sh /entry.sh
RUN chmod +x /entry.sh

EXPOSE 40400 8080

ENTRYPOINT ["/entry.sh"]
