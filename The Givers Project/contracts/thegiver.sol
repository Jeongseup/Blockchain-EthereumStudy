pragma solidity 0.8.6;

contract DonationContract {
    
    // event Donate
    event Donate (
        Giver giver
    );
    
    // giver struct
    struct Giver {
        string name;
        address account;
        uint amount;
    }
    
    Giver[] givers;
    
    // giver property & latest giver
    string nickName;
    address account;
    uint amount;
    
    mapping(address => uint) giveCount;
    
    
    function donate(string memory _nickName) public payable{
        
        nickName = _nickName;
        account = msg.sender;
        amount = msg.value;
        
        Giver memory g = Giver(_nickName, account, amount);
        givers.push(g);
        giveCount[msg.sender]++;
        emit Donate(g);
    }

    function getLatestGiver() view public returns (string memory, address, uint) {
        return (nickName, account, amount);
    }
    
    function getTotalGivers() public view returns(uint) {
        return(givers.length);
    }
    
    function getMyGiveCount() public view returns (uint) {
        return(giveCount[msg.sender]);
    }
    
    function getGivers() public view returns (Giver[] memory ){
        return givers;
    }
    
}