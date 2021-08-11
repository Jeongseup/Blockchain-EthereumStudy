pragma solidity 0.8.6;

import "./zombieattack.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/math/SafeMath.sol";

contract artOwnership is ERC721 {
    
  using SafeMath for uint256;

  function balanceOf(address _owner) public view returns (uint256 _balance) {
    return ownerArtCount[_owner];
  }

  function ownerOf(uint256 _tokenId) public view returns (address _owner) {
    return artToOwner[_tokenId];
  }

  function _transfer(address _from, address _to, uint256 _tokenId) private {
    ownerZombieCount[_to] = ownerZombieCount[_to].add(1);
    ownerZombieCount[msg.sender] = ownerZombieCount[msg.sender].sub(1);
    zombieToOwner[_tokenId] = _to;
    Transfer(_from, _to, _tokenId);
  }

  function transfer(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
    _transfer(msg.sender, _to, _tokenId);
  }

  function approve(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
    zombieApprovals[_tokenId] = _to;
    Approval(msg.sender, _to, _tokenId);
  }

  function takeOwnership(uint256 _tokenId) public {
    require(zombieApprovals[_tokenId] == msg.sender);
    address owner = ownerOf(_tokenId);
    _transfer(owner, msg.sender, _tokenId);
  }
}
