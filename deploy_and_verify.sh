#!/bin/bash

RPC_URL="https://rpc.testnet.arc.network"

echo "===================================================="
echo "🚀 Monad Arc — Auto Deploy & Verify Script"
echo "🔧 Contract: HelloArchitect"
echo "🔗 RPC Endpoint: $RPC_URL"
echo "===================================================="
echo ""

# Run deployment (stdout + stderr combined) → deploy.log
forge script script/DeployHelloArchitect.s.sol \
  --rpc-url $RPC_URL \
  --broadcast -vv > deploy.log 2>&1

# Extract contract address (matching any 0x...40 hex)
ADDRESS=$(grep -oiE "0x[a-fA-F0-9]{40}" deploy.log | tail -1)

echo "===================================================="
echo "📦 Contract deployed at:"
echo "➡️  $ADDRESS"
echo "===================================================="

# Validate address
if [ -z "$ADDRESS" ]; then
    echo "❌ ERROR: Contract address not found!"
    echo "Please check the deployment log manually:"
    echo "cat deploy.log"
    exit 1
fi

echo ""
echo "🔍 Starting verification on ArcScan..."
echo ""

forge verify-contract \
  --rpc-url $RPC_URL \
  --verifier blockscout \
  --verifier-url 'https://testnet.arcscan.app/api/' \
  --chain-id 827431 \
  $ADDRESS \
  src/HelloArchitect.sol:HelloArchitect

echo ""
echo "===================================================="
echo "🎉 VERIFICATION COMPLETE!"
echo "📌 Contract Address : $ADDRESS"
echo "🔎 ArcScan URL      : https://testnet.arcscan.app/address/$ADDRESS?tab=contract"
echo "===================================================="
echo ""
echo "🔥 Powered by 0xjfmjf"
echo "🐦 X/Twitter: https://x.com/0xmjfmjf"
echo "===================================================="
