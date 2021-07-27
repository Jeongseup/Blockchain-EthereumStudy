// 0xF1895232940b1eA9DfFc5927DC005A4f198BD5F7

pragma solidity 0.8.6;

contract Test4 {
    
    constructor() payable {
        
    }
    
    function destroy() public {
        selfdestruct(payable(0xBa5e1E58df8F0464Ee6F9E65F4A7AF57b41c5606));
    }
    
}