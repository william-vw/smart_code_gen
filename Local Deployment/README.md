# Instructions

## Setup
- Run `npm install` within this folder and [`web3/`](web3/) subfolder.
- Install [Ganache UI](https://trufflesuite.com/ganache/)  
(UI allows checking issued events, which is not supported by ganache-cli)

## Run Ganache UI
If first time in UI:
- New workspace > Add project > select `contract/truffle-config.js` > Start (button at right top)
- Note port number ("RPC server" on top bar) & update `contract/truffle-config.js` (networks > development > port) & `web3/*.js` (if needed)

## Run a test case

### 1) Compile & deploy contract
- `%> sudo ./deploy_contract.sh <case>` (e.g., case1)

### 2) Run client & oracle
- `web3 % node oracle.js <test>` (e.g., test1)  
after running `client.js`, outputs the received requests & a summary of what was sent back.  

- `web3 % node client.js <test>` (e.g., test1)  
outputs the response received from the contract.  

`<test>` will be one of the tests under `web3/test/<case>/` (e.g., test1).  
(NOTE: `oracle.js` and `client.js` will already be using the `<case>` from `deploy_contract.sh`)  

See [`web3/test`](web3/test) for instructions on how to run all contract tests.

<!-- ### Troubleshooting
- When getting the following error when running `client.js`:
```
ContractExecutionError: Error happened while trying to execute a function inside a smart contract
```

Try creating a new Ganache workspace to start fresh with a new chain. -->


## NOTE: how to start a new project
**(already done for this repository!)**

- Folder structure:  
`contract/`  
`web3/`  

- Run `web3 % npm install`

- Run `contract % truffle init`

- In `truffle-config.js`:  
  - Uncomment `development` object (under `networks`)  
  - Change `solc` version to `0.8.17` (otherwise get deployment error "hit an invalid opcode")

- Create a smart contract: `truffle create contract <contract>`

- Under `contract/migrations`, add file `2_deploy_contracts.js` (with this specific name!) with the following contents:
```
var MyContract = artifacts.require("./<contract>.sol");
module.exports = function (deployer) { deployer.deploy(MyContract); }
```

## NOTE: how to manually deploy contract
**(not necessary if shell script was run!)**

- Compile new ABI (~ "stub") to be referred by web3js:  
(if name changed, copy new filename to `web3/*.js`)
```
web3 % solcjs ../contract/contracts/<contract>.sol --abi
```

- Re-compile contract & deploy ("migrate") to ganache
```
contract % sudo truffle migrate
```

- Note new contract address & update `web3/.env`
