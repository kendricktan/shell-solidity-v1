#!/usr/bin/env bash
source .sethrc && dapp build && DAPP_TEST_ADDRESS=0x22ee350346F93B9191af9a70cfFA8c5746BdfD14 DAPP_TEST_NUMBER=$(seth block latest number) DAPP_TEST_TIMESTAMP=$(seth block latest timestamp) hevm dapp-test --rpc $ETH_RPC_URL --json-file="out/dapp.sol.json" --verbose 2
