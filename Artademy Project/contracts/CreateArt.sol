pragma solidity 0.8.6;

import "./ownable.sol";

contract createArt is Ownable {
    
    using SafeMath for uint256;

    mapping (uint => address) public artToOwner;
    mapping (address => uint) ownerArtCount;
    
    modifier onlyOwnerOf(uint _artId) {
        require(msg.sender == artToOwner[_artId]);
        _;
    }
    
    event NewZombie(uint zombieId, string name, uint dna);

    struct Art {
        string name;
        string createdBy;
        string inspiredBy;
        uint32 createdTime;
    }

    Art[] public arts;


    function _createZombie(string _name, uint _dna) internal {
        uint id = zombies.push(Zombie(_name, _dna, 1, uint32(now + cooldownTime), 0, 0)) - 1;
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;
        NewZombie(id, _name, _dna);
    }

    function createRandomZombie(string _name) public {
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        randDna = randDna - randDna % 100;
        _createZombie(_name, randDna);
     }

    
    function getZombiesByOwner(address _owner) external view returns(uint[]) {
        uint[] memory result = new uint[](ownerZombieCount[_owner]);
        uint counter = 0;
        for (uint i = 0; i < zombies.length; i++) {
          if (zombieToOwner[i] == _owner) {
            result[counter] = i;
            counter++;
          }
        }
        
        return result;
    }
}


library SafeMath { 
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
      assert(b <= a);
      return a - b;
    }
    
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
      uint256 c = a + b;
      assert(c >= a);
      return c;
    }
}





