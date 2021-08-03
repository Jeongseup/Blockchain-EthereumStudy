pragma solidity 0.8.6;

contract counter {
    
    uint count = 0;
     
    // function increment(uint _count) public {
    //     count + _count;
    // }
    
    function increment() public {
       count ++;
    }
    
    
    function getCount() public view returns(uint) {
        return(count);
    }
}
