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

    // receive result events
    // (fromBlock: update to avoid getting older events)
    const evt = contract.events.ContractResponse({ filter: { value: [] }, fromBlock: process.env.BLOCK_NR });
    evt.on("connected", function (subscriptionId) { console.log("subscriptionId:", subscriptionId); });
    evt.on('data', async function (event) { 
        let response = event.returnValues.evt

        console.log(`> contract response (${process.env.CONTRACT_NAME})`);
        // console.log(response);
        console.log("patient:", response.patient.id); 
        console.log("request (medication):", response.request.medication[0].concept);
        console.log("outcome: ", response.outcome)
    });

    let request = require(`./test/${process.env.CONTRACT_NAME}/${test}/client.js`).request;
    // console.log(request);

    // call contract to process request
    await contract.methods.process(request).send({ from: account, gas: 3000000, gasPrice: 20000000000 });
}
run();