require("dotenv").config();
const { Web3 } = require("web3");
const fs = require('fs');

// update when deploying contract
const CONTRACT_ADDRESS = process.env.CONTRACT_ADDRESS;
// ("ws" protocol needed for event subscriptions)
const web3 = new Web3("ws://127.0.0.1:7545"); // copy port from ganache ui / cli output
// contract's ABI stub
const abi = JSON.parse(fs.readFileSync(process.env.CONTRACT_FILE));
const contract = new web3.eth.Contract(abi, CONTRACT_ADDRESS);

const test = process.argv[2];

async function run() {
    const accounts = await web3.eth.getAccounts();
    const account = accounts[0];

    let data = require(`./test/${process.env.CONTRACT_NAME}/${test}/oracle.js`);

    // receive request events
    // (fromBlock: update to avoid getting older events)
    const evt = contract.events.OracleRequest({ filter: { value: [] }, fromBlock: process.env.BLOCK_NR });
    evt.on("connected", function (subscriptionId) { console.log("subscriptionId:", subscriptionId); });
    evt.on('data', async function (event) {
        let request = event.returnValues.request;
        console.log("> oracle request:", request.resource, request.parameters, request.callback);
        let req = request.req;

        let method = contract.methods[request.callback];
        switch (request.resource) {
            case 'Claim':
                var claims = ( data.claim ? [ data.claim ] : [] );
                await method(req, claims).send({ from: account, gas: 3000000 });
                console.log("sent claims");
                break;

            case 'Coverage':
                var coverages = ( data.coverage ? [ data.coverage ] : [] );
                await method(req, coverages).send({ from: account, gas: 3000000 });
                console.log("sent coverages"); 
                break;
        }
    })
}
run();