# aztec-node-docker


### Aztec Node Docker
A Dockerized setup for running an Aztec sequencer node on the alpha-testnet.

## Prerequisites
- Docker installed
- Sepolia RPC URL (e.g., from Infura or Alchemy)
- Beacon RPC URL
- Ethereum wallet address and private key

## Usage
1. Build the Docker image:
   ```bash
   docker build -t aztec-node .
   ```
2. Run the containe:
     ```bash
     docker run -it -p 40400:40400 -p 8080:8080 aztec-node
     ```

