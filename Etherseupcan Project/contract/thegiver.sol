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
        
        account = msg.sender;
        amount = msg.value;
        
        payable(account).transfer(amount);
        
        Giver memory g = Giver(_nickName, account, amount);
        givers.push(g);
        giveCount[msg.sender]++;
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
    
    function getGivers() public view returns (Giver[] memory ){
        return givers;
    }
}