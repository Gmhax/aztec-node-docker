FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    ufw \
    screen \
    && rm -rf /var/lib/apt/lists/*

# 👇 FIXED: Proper bash install command
RUN curl -s https://install.aztec.network -o install.sh && \
    bash install.sh

ENV PATH="/root/.aztec/bin:${PATH}"
RUN aztec-up alpha-testnet
RUN ufw allow 40400 && \
    ufw allow 8080 && \
    ufw --force enable

COPY entry.sh /entry.sh
RUN chmod +x /entry.sh
EXPOSE 40400 8080
ENTRYPOINT ["/entry.sh"]
