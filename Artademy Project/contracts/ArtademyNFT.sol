// 0xfC0FEDE6863bEB622D293Ba28c655db402fbAf4E
pragma solidity 0.8.6;

import "./ERC721.sol";
import "./ArtFactory.sol";

contract ArtOwnership is ERC721, ArtFactory {

  using SafeMath for uint256;
  
  mapping (uint => address) artApprovals;

  function balanceOf(address _owner) override public view returns (uint256 _balance) {
    return ownerArtCount[_owner];
  }

  function ownerOf(uint256 _tokenId) override public view returns (address _owner) {
    return artToOwner[_tokenId];
  }

  function _transfer(address _from, address _to, uint256 _tokenId) private {
    ownerArtCount[_to] = ownerArtCount[_to].add(1);
    ownerArtCount[msg.sender] = ownerArtCount[msg.sender].sub(1);
    artToOwner[_tokenId] = _to;
    emit Transfer(_from, _to, _tokenId);
  }

  function transfer(address _to, uint256 _tokenId) override public onlyOwnerOf(_tokenId) {
    _transfer(msg.sender, _to, _tokenId);
  }

  function approve(address _to, uint256 _tokenId) override public onlyOwnerOf(_tokenId) {
    artApprovals[_tokenId] = _to;
    emit Approval(msg.sender, _to, _tokenId);
  }

  function takeOwnership(uint256 _tokenId) override public {
    require(artApprovals[_tokenId] == msg.sender);
    address owner = ownerOf(_tokenId);
    _transfer(owner, msg.sender, _tokenId);
  }
}

