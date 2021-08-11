pragma solidity 0.8.6;


contract Hello {
    
    function getBlockNumber() public returns (uint) {
        return(block.number);
    }
}
