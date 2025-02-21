

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blockchain ChatApp</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/web3/1.7.3/web3.min.js"></script>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; }
        #chat { max-width: 500px; margin: auto; border: 1px solid #ccc; padding: 20px; }
        #messages { height: 300px; overflow-y: scroll; border: 1px solid #ccc; padding: 10px; }
        #inputMsg { width: 80%; padding: 5px; }
        button { padding: 10px; margin-top: 10px; cursor: pointer; }
    </style>
</head>
<body>
    <h2>Blockchain ChatApp</h2>
    <button onclick="connectWallet()">Connect Wallet</button>
    <div id="chat">
        <h3>Messages</h3>
        <div id="messages"></div>
        <input type="text" id="inputMsg" placeholder="Type a message...">
        <button onclick="sendMessage()">Send</button>
    </div>
    
    <script>
        let web3;
        let contract;
        const contractAddress = "0x892DC0D8c80937f7e3E0221971892dfDdd72aB72";
        const contractABI = [
        [
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "sender",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "string",
				"name": "text",
				"type": "string"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "timestamp",
				"type": "uint256"
			}
		],
		"name": "NewMessage",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_user",
				"type": "address"
			}
		],
		"name": "getMessages",
		"outputs": [
			{
				"components": [
					{
						"internalType": "address",
						"name": "sender",
						"type": "address"
					},
					{
						"internalType": "string",
						"name": "text",
						"type": "string"
					},
					{
						"internalType": "uint256",
						"name": "timestamp",
						"type": "uint256"
					}
				],
				"internalType": "struct ChatDApp.Message[]",
				"name": "",
				"type": "tuple[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_text",
				"type": "string"
			}
		],
		"name": "sendMessage",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
]
        ];

        async function connectWallet() {
            if (window.ethereum) {
                web3 = new Web3(window.ethereum);
                await window.ethereum.request({ method: "eth_requestAccounts" });
                contract = new web3.eth.Contract(contractABI, contractAddress);
                alert("Wallet connected!");
            } else {
                alert("Please install MetaMask!");
            }
        }

        async function sendMessage() {
            const accounts = await web3.eth.getAccounts();
            const message = document.getElementById("inputMsg").value;
            if (!message) return alert("Enter a message");

            await contract.methods.sendMessage(message).send({ from: accounts[0] });
            document.getElementById("messages").innerHTML += `<p><b>You:</b> ${message}</p>`;
            document.getElementById("inputMsg").value = "";
        }
    </script>
</body>
</html>
