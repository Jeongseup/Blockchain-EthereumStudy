pragma solidity 0.8.6;

contract Test6 {
    
    constructor() payable {
        
    }
    
    function withdraw() public {
        require(address(this).balance >= 0.01 ether);
        payable(msg.sender).transfer(address(this).balance);
    } 
    
}


// contract Test6 {
    
//     constructor() payable {
        
//     }
    
//     function destroy() public {
//         selfdestruct(payable(0x60Cb95B302A50aEb6bC481675D7a2EDccC41D75b));
//     }
    
// }