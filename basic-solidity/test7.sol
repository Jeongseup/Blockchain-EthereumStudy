pragma solidity 0.8.6;

contract Test7 {
    
    constructor() payable {
        
    }
    
    function withdraw() public {
        require(address(this).balance >= 0.01 ether);
        payable(msg.sender).transfer(address(this).balance);
    } 
    
}


contract attackTest7 {
    
    constructor() payable {
        
    }
    
    function destroy() public {
        selfdestruct(payable(0x803Bc7E7B6DeEEcB6FD64613EC479fC79C41FCb6));
    }
    
}