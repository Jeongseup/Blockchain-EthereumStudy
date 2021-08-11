pragma solidity 0.8.6;

contract Test4 {
    
    uint public balance;
    
    constructor() payable {
        balance = msg.value;
    }
    
    fallback() external payable {
        require(msg.value >= balance);
        payable(msg.sender).transfer(address(this).balance);   
    }
    
}
