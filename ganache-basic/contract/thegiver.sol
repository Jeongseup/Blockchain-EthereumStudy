pragma solidity 0.8.6;


contract donation {

    // giver property
    string nickName;
    address account;
    uint amount;
    
    mapping(address => uint) giveCount;
    
    // giver struct
    struct Givers {
        string name;
        address account;
        uint balance;
    }
    
    // event Donate
    event Donate (
        Givers giver
    );
    
    Givers[] givers;
    
    function donate(string memory _nickName) public payable{
        require(msg.value != 0, "Insufficient funds to allow transfer");
        
        if (keccak256(abi.encodePacked(_nickName)) == keccak256(abi.encodePacked(""))){
            nickName = "none";
        } else {
            nickName = _nickName;
        }
        
        account = msg.sender;
        amount = msg.value;
        
        
        payable(account).transfer(amount);
        
        giveCount[msg.sender]++;
        Givers memory g = Givers(nickName, account, amount);
        givers.push(g);
        
        emit Donate(g);
    }
    
    function getLastgiver() view public returns (string memory, address, uint) {
        return (nickName, account, amount);
    }
    
    function getTotalgivers() public view returns(uint) {
        return(givers.length);
    }
    
    function getGiveCount() public view returns (uint) {
        return(giveCount[msg.sender]);
    }
    
}