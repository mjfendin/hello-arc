#!/bin/bash

ADDRESS=$1

forge verify-contract \
  --rpc-url https://rpc.testnet.arc.network \
  --verifier blockscout \
  --verifier-url 'https://testnet.arcscan.app/api/' \
  --chain-id 827431 \
  $ADDRESS \
  src/HelloArchitect.sol:HelloArchitect