
pragma solidity 0.8.6;

contract Test3 {
    
    constructor() payable {
    }
    
    fallback() external {
        payable(msg.sender).transfer(address(this).balance);   
    }
    
}
