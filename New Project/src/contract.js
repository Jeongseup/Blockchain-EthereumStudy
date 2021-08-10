let myContractAddress = "0xA0DA2C355a2739Cf30fb99Bb3774c8EA511aB9E9";
let abi = [{
        "anonymous": false,
        "inputs": [{
            "components": [{
                    "internalType": "string",
                    "name": "name",
                    "type": "string"
                },
                {
                    "internalType": "address",
                    "name": "account",
                    "type": "address"
                },
                {
                    "internalType": "uint256",
                    "name": "amount",
                    "type": "uint256"
                }
            ],
            "indexed": false,
            "internalType": "struct DonationContract.Giver",
            "name": "giver",
            "type": "tuple"
        }],
        "name": "Donate",
        "type": "event"
    },
    {
        "inputs": [{
            "internalType": "string",
            "name": "_nickName",
            "type": "string"
        }],
        "name": "donate",
        "outputs": [],
        "stateMutability": "payable",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "getGivers",
        "outputs": [{
            "components": [{
                    "internalType": "string",
                    "name": "name",
                    "type": "string"
                },
                {
                    "internalType": "address",
                    "name": "account",
                    "type": "address"
                },
                {
                    "internalType": "uint256",
                    "name": "amount",
                    "type": "uint256"
                }
            ],
            "internalType": "struct DonationContract.Giver[]",
            "name": "",
            "type": "tuple[]"
        }],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "getLatestGiver",
        "outputs": [{
                "internalType": "string",
                "name": "",
                "type": "string"
            },
            {
                "internalType": "address",
                "name": "",
                "type": "address"
            },
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "getMyGiveCount",
        "outputs": [{
            "internalType": "uint256",
            "name": "",
            "type": "uint256"
        }],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "getTotalGivers",
        "outputs": [{
            "internalType": "uint256",
            "name": "",
            "type": "uint256"
        }],
        "stateMutability": "view",
        "type": "function"
    }
];

let provider;
let web3;
let account;

async function init() {
    // contract.js import cofirm
    console.log("My Application Binary Interface is ", abi);
    console.log("My Contract Address is ", myContractAddress);

    if (window.ethereum) {
        web3 = new Web3(window.ethereum);
        try {

            // connect 
            await getContract();
            await getTotalGivers();

        } catch (error) {
            console.log(error);
        }
    }
    // Legacy dapp browsers...
    else if (window.web3) {
        // Use Mist/MetaMask's provider.
        web3 = window.web3;
        console.log("Injected web3 detected.");
    }
}

// init Contract
function getContract() {
    console.log("getContract Compute!")
    myContract = new web3.eth.Contract(abi, myContractAddress);

    myContract.events.Donate({}, function (error, event) {
            console.log("Now on, Watching Contract events!");

            if (!error)
                console.log(event);
        })
        .on('data', function (event) {
            console.log(event); // same results as the optional callback above
        });
};

function getTotalGivers() {
    console.log("Use getTotalGivers function!");

    myContract.methods.getTotalGivers().call({}).then(function (result) {
        // console.log(result);
        document.getElementById("p_totalgivers").innerText = `Current Total Givers are ${result}!`;
    });
};

async function connectWallet() {
    console.log("Use connectWallet function!");

    // Request account access if needed
    await window.ethereum.enable();

    // get balacne in connected account
    web3.eth.getAccounts().then(function (accounts) {
        account = accounts[0]
        console.log("Login Address is :", account);

        web3.eth.getBalance(account).then(function (balance) {

            // parse & convert balacne
            var sBalance = web3.utils.fromWei(String(balance), "ether").slice(0, 8);
            console.log(sBalance);

            var item = document.getElementById("btn_connectwallet");
            item.innerText = "Connected";
            item.classList.add("disabled");

            // document.getElementById("input_mybalacne").innerHTML =
            //     `<h3> Your Current Balane is ${balance} ether !<h3>`;
        });
    });
}


function getLatestGiver() {
    console.log("Use getLatestGiver function!");

    //contract call
    myContract.methods.getLatestGiver().call({}).then(function (result) {
        console.log(result);
        let _nickName = result[0] == "" ? "none" : result[0];
        let _account = result[1];


        let _balance = web3.utils.fromWei(String(result[2]), "ether").slice(0, 8);

        document.getElementById("input_info1").value = _nickName;
        document.getElementById("input_info2").value = _account;
        document.getElementById("input_info3").value = _balance + " ETH";
    });
}

function getMyGiveCount() {
    if (account == undefined) {
        return window.alert("Connect your wallet!");
    }
    console.log("Use getMyGiveCount function!");

    myContract.methods.getMyGiveCount().call({
        from: account
    }).then(function (result) {
        console.log(result);
        document.getElementById("input_count").value = result;
    });
}


function donate() {
    if (account == undefined) {
        return window.alert("Connect your wallet!");
    } else {

        let _nickName = document.getElementById("input_nickname").value;

        myContract.methods.donate(_nickName).send({
                from: account,
                value: web3.utils.toWei("1", "finney"),
                // gas: 200000,
                // gasPrice:
            })
            .on('transactionHash', function (hash) {
                // console.log(hash);
            })
            .on('receipt', function (receipt) {
                console.log(receipt);
            })
            .on('error', function (error, receipt) {
                console.log(error, receipt);
            });
    }
};


function getGivers() {
    console.log("Use getGivers function");

    //contract call
    myContract.methods.getGivers().call({}).then(function (result) {
        console.table(result);
    });
};