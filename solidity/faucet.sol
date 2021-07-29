pragma solidity 0.8.6;


contract faucet {


    uint public currentEther;
    string public lastDonaterMsg;
    mapping(address => uint) public getEtherCount;
    
    
    constructor() payable {
        currentEther = msg.value / (10 ** 18);
    }
    
    
    function getEther(address _address) public{
        
        require(getEtherCount[_address] < 1, "Has no right to vote");
 
        
        payable(_address).transfer(1 ether);
        currentEther -= 1;
        getEtherCount[_address]++;
   
    }
    
    
    function donate(string memory _message) public payable{
        currentEther += msg.value / (10 ** 18);
        
        if(getEtherCount[msg.sender] == 1){
            getEtherCount[msg.sender]--;
        }
        
        if (keccak256(abi.encodePacked(_message)) != keccak256("")) {
            lastDonaterMsg = _message;
        }
        
    }
    
}

