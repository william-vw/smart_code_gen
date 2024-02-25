#!/bin/bash

name=$1 # case1, case2, or case3

echo ">> COMPILING CONTRACT"

file=contract_contracts_$name\_sol_$name.abi
sudo solcjs contract/contracts/$name.sol --abi
mv -f $file web3/

echo ">> DEPLOYING CONTRACT"

echo -e "var MyContract = artifacts.require(\"./$name.sol\");\nmodule.exports = function (deployer) { deployer.deploy(MyContract); }" > contract/migrations/2_deploy_contracts.js

cd contract/
output=$(sudo truffle migrate)
# echo $output

addr_regex='contract address:[[:space:]]*([0-9A-Za-zx]*)'
[[ $output =~ $addr_regex ]]
address=${BASH_REMATCH[1]}

block_regex='block number:[[:space:]]*([0-9]*)'
[[ $output =~ $block_regex ]]
block=${BASH_REMATCH[1]}

cd ..

echo -e "CONTRACT_NAME = $name\nCONTRACT_FILE= $file\nCONTRACT_ADDRESS = $address\nBLOCK_NR = $block" > web3/.env

echo "$output" > "output.txt"
echo "(see output.txt for deployment output)"