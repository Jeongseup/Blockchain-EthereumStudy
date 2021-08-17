// 0x03c816A65268dFd2b8eA4938763959ff8d47CbBd
pragma solidity 0.8.6;

contract ArtFactory{
    
    using SafeMath for uint256;

    modifier onlyOwnerOf(uint _artId) {
        require(msg.sender == artToOwner[_artId]);
        _;
    }
    
    event NewArt(uint artId, string name, string createdBy);

    struct Art {
        string name;
        string createdBy;
        string inspiredBy;
        uint256 createdTime;
    }

    Art[] public arts;
    
    mapping (uint => address) public artToOwner;
    mapping (address => uint) ownerArtCount;
    
    // require only students
    function createArt(string memory _name, string memory _createdBy, string memory _inspiredBy) public {

        // Art { name, createdBy, inspiredBy, createdTime }
        arts.push(Art(_name, _createdBy, _inspiredBy, block.timestamp));
        uint id = arts.length - 1;
        
        artToOwner[id] = msg.sender;
        ownerArtCount[msg.sender] = ownerArtCount[msg.sender].add(1);
        
        // Event Emit
        // NewArt ( artId, name, createdBy);
        emit NewArt(id, _name, _createdBy);
    }
    
    function getArtsByOwner(address _owner) external view returns(uint[] memory) {
        uint[] memory result = new uint[](ownerArtCount[_owner]);
        
        uint counter = 0;
        uint loopLength = arts.length;
        
        for (uint i = 0; i < loopLength; i++) {
          if (artToOwner[i] == _owner) {
            result[counter] = i;
            counter++;
          }
        }
        
        return result;
    }
    
    function getTotalArts() public view returns(uint) {
        return(arts.length);
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





