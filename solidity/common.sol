pragma solidity 0.8.6;


contract Common {
    
    function sliceNumExceptDigit(uint _num, uint _digit) public pure returns(uint) {
    return  _num - _num % (10 ** _digit);
    }
    
    function sliceNumUntilDigit(uint _num, uint _digit) public pure returns(uint) {
    return  _num % (10 ** _digit);
    }
}
