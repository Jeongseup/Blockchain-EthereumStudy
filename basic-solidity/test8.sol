pragma solidity 0.8.6;

contract Test8 {
    string public name = "vitalik";
    
    function setName(string memory _n) public {
        name = _n;
    }
}

contract attactkTest8 {
    
    function setName(string memory _n) public {
        Test8(0xB23BAa05E7aE94F2a7bA1C6122cC90692597f903).setName(_n);
    }
    
}