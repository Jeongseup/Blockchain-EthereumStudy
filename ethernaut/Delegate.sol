// SPDX-License-Identifier: MIT
pragma solidity 0.8.6;

contract Delegate {

  address public owner;
  event Test(address sender);
          
  constructor(address _owner) public {
    owner = _owner;
  }

  function pwn() public returns (address) {
    owner = msg.sender;
    emit Test(msg.sender);
    
    return(owner);
  }
  
}

contract Delegation {

  address public sender;

  address public owner;
  event Test(bool a, bytes b);
  
  Delegate delegate;

  constructor(address _delegateAddress) public {
    delegate = Delegate(_delegateAddress);
    owner = msg.sender;
  }

  fallback() external {
    (bool result, bytes memory sender) = address(delegate).delegatecall(msg.data);
   
    
    if (result) {
        this;
    }
  }
}