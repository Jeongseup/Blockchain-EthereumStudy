
pragma solidity 0.8.6;
// contract Test {
    
//     address owner;
//     uint public bal;
    
//     constructor() payable {
//         owner = msg.sender;
//         bal = msg.value;
//     }
    
//     function withdraw() public {
//         require(msg.sender == owner );
//         payable(msg.sender).transfer(address(this).balance);
//     }
// }

contract Test2 {
    
    address owner;
    
    constructor() payable {
      owner = msg.sender;   
    }
    
    function changeOwner() public {
        owner = msg.sender;
    }
    
    function getCurrentOwner() public view returns (address) {
        return owner;
    }
    
    function withdraw() public {
        payable(owner).transfer(0.001 ether);
    }
    
}