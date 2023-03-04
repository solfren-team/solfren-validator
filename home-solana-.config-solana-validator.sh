#!/bin/bash

solana-validator \
  --rpc-port 8899 \
  --full-rpc-api \
  --no-voting \
  --enable-rpc-transaction-history \
  --rpc-bind-address 0.0.0.0 \
  --private-rpc \
  --entrypoint entrypoint.mainnet-beta.solana.com:8001 \
  --entrypoint entrypoint2.mainnet-beta.solana.com:8001 \
  --entrypoint entrypoint3.mainnet-beta.solana.com:8001 \
  --entrypoint entrypoint4.mainnet-beta.solana.com:8001 \
  --entrypoint entrypoint5.mainnet-beta.solana.com:8001 \
  --no-wait-for-vote-to-start-leader \
  --wal-recovery-mode skip_any_corrupted_record \
  --limit-ledger-size 100000000 \
  --log /home/solana/.config/solana/solana-validator.log \
  --snapshot-interval-slots 7200 \
  --maximum-local-snapshot-age 7200 \
  --identity /home/solana/.config/solana/validator-keypair.json \
  --dynamic-port-range 8000-8020 \
  --ledger /home/solana/ledger
