#!/bin/bash
prompt_input() {
    local prompt=$1
    local var_name=$2
    local default=$3
    read -p "$prompt [$default]: " input
    eval $var_name="${input:-$default}"
}
prompt_sensitive() {
    local prompt=$1
    local var_name=$2
    local default=$3
    read -s -p "$prompt: " input
    echo
    eval $var_name="${input:-$default}"
}
prompt_input "Enter Sepolia RPC URL" SEPOLIA_RPC "https://rpc.sepolia.org"
prompt_input "Enter Beacon RPC URL" BEACON_RPC "https://beacon.sepolia.dev"
prompt_input "Enter your wallet address (0x...)" WALLET_ADDRESS ""
prompt_sensitive "Enter your private key (0x...)" PRIVATE_KEY ""
if [ -z "$WALLET_ADDRESS" ] || [ -z "$PRIVATE_KEY" ]; then
    echo "Error: Wallet address and private key are required."
    exit 1
}
PUBLIC_IP=$(curl -s ipv4.icanhazip.com)
if [ -z "$PUBLIC_IP" ]; then
    echo "Error: Could not retrieve public IP."
    exit 1
}
screen -dmS aztec bash -c "aztec start --node --archiver --sequencer \
  --network alpha-testnet \
  --l1-rpc-urls $SEPOLIA_RPC \
  --l1-consensus-host-urls $BEACON_RPC \
  --sequencer.validatorPrivateKey $PRIVATE_KEY \
  --sequencer.coinbase $WALLET_ADDRESS \
  --p2p.p2pIp $PUBLIC_IP \
  --p2p.maxTxPoolSize 1000000000"
tail -f /dev/null
