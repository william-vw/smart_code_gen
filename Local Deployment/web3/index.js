const { Web3 } = require("web3");

// Replace with your actual Alchemy WebSocket URL
const alchemyWebSocketURL = "wss://eth-sepolia.g.alchemy.com/v2/Z7zJegFPnFBOOIZiji4H_XaTSKO1cfcS";

const web3 = new Web3(new Web3.providers.WebsocketProvider(alchemyWebSocketURL));

web3.eth.net.isListening()
    .then(() => console.log("Connected successfully to Alchemy WebSocket"))
    .catch(e => console.error("Failed to connect:", e));
