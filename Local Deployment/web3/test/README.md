# Test Instructions


## Per case
### Compile & deploy contract
`%> deploy.sh <case>` (case1, case2 or case3)

## Per case test
### Run `oracle.js` & `client.js`
`web3%> node oracle.js <test>` (test1-10)  
`web3%> node client.js <test>` (test1-10)

**NOTE**: after running a test, update the BLOCK_NR in `web3/.env` to be Ganache's current block number + 1. 
This way, you won't see prior output showing up for `oracle.js` and `client.js`.