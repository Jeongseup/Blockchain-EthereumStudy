pragma solidity 0.8.6;

contract Send{
    
    address owner;
    
    constructor() payable {
        owner = msg.sender;
    }
    
    function withdraw(address _to) public {
        require(tx.origin == owner);
        payable(_to).transfer(address(this).balance);
    } 
    
}