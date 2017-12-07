pragma solidity ^0.4.0;

contract ConcertToken{
    uint public totalTickets;  // total number of tickes available
    address owner; // the one who owns the ConcertToken
    uint public constant price = 1.5 ether;
    
    mapping  (address => uint) public buyers;
    
    function ConcertToken(uint _totalTickets){
        totalTickets = _totalTickets;
        owner  = msg.sender;
    }
    
    function buyTickets(uint _requiredTickets) payable{
        assert( 
            (msg.value == (_requiredTickets * price) ) 
            && (_requiredTickets < totalTickets)
        );
        buyers[msg.sender] += _requiredTickets;
        totalTickets -= _requiredTickets;
        
        //Once all tickes are bought -> send all ethers to the owner of the contract
        // for this, we will user selfdestruct
        if(totalTickets == 0){
            selfdestruct(owner);
        }
        
        
    }
    
    
    
    
    
}      
