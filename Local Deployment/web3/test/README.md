# Test Instructions


## Per case
### Compile & deploy contract
- `%> deploy_contract.sh <case>` (case1, case2 or case3)

## Per case test
### Run `oracle.js` & `client.js`
- `web3%> node oracle.js <test>` (test1-10)  
after running `client.js`, outputs the received requests & a summary of what was sent back.  

- `web3%> node client.js <test>` (test1-10)  
outputs the response received from the contract.  

**NOTE**: after running a test, update `BLOCK_NR` in `web3/.env` to be Ganache's current block number + 1 (top bar, "Current Block"). 
This way, you won't see prior output showing up for `oracle.js` and `client.js`.

**NOTE**: see [Evaluation Results/outcomes.xlsx](<../../../Evaluation Results/outcomes.xlsx>) for the expected outcomes per test.
