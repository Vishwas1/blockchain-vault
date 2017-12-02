pragma solidity 0.4.0;
/**
    //APIs needs to be implemented for ERC20 standards...
    contract ERC20 {
        function totalSupply() constant returns (uint totalSupply);
        function balanceOf(address _owner) constant returns (uint balance);
        function transfer(address _to, uint _value) returns (bool success);
        function approve(address _spender, uint _value) returns (bool success);
        function allowance(address _owner, address _spender) constant returns (uint remaining);
        function transferFrom(address _from, address _to, uint _value) returns (bool success);
        event Transfer(address indexed _from, address indexed _to, uint _value);
        event Approval(address indexed _owner, address indexed _spender, uint _value);
    }

*/
//-------------------------------------------------------------//

contract TemplateCoin {

    string public constant name = "Template Token";
    string public constant symbol = "TCK";

    /**
        E.g. decimal = 0 : value = 100 -> 100 tokens
        E.g. decimal = 1 : value = 100 -> 10.0 tokens
        E.g. decimal = 2 : value = 100 -> 1.00 tokens
     */
    uint8 public constant decimal = 0;
    string public constant version = "0.1";

    // Backed by ether state ->  user can pay actual ether to buy your token..and they can 
    // sell you token for ether through your contract.
    uint256 public buyPrice; // what price of ether a token cost
    uint266 public sellPrice; // what price of ether a token sell for

    mapping (address=> uint256) public balances;
    mapping (address=> mapping (address=>uint256)) public allowances;
    uint256 public totalSupply;


    event Transfer(address indexed _from, address indexed _to, uint _value); //Log if any one has transfered anything
    event Approval(address indexed _owner, address indexed _spender, uint _value); //Log for approval

    function TemplateCoin(uint256 _initialValue) {
        balances[msg.sender] = _initialValue;
        totalSupply = _initialValue;
    }

    /**
        Usage : Returns the balance of a particular address
     */
    function balanceOf(address _owner) constant returns (uint256 balance) {
        return balances[_owner];
    }

    /**
        Usage : To transfer TemplateCoin from token creator's account to _to address
     */
    function transfer(address _to, uint256 _value) returns (bool success) {
        //do necessary checking here
        if(_value <= 0 || balances[msg.sender] < _value ) return false;
        if(balances[_to] + _value < balances[_to]) return false; //dont understand why this check is necessary
        balances[msg.sender] -= _value;
        balances[_to] += _value; 
        Transfer(msg.sender, _to, _value);
        return true;
    }

    /**
        Usage : Basically called by a person who wou;d like to approve, the spender To approve the exchange to 
                transfer some/all TemplateCoin to someone's account on your behalf.
        Params :
            _spender : the account to which caller wants to approve
            _value : the amount of token that the caller wants _spender to approve.

     */
    function approve(address _spender, uint256 _value) returns (bool success) {
        if(_value <= 0) return false;
        allowances[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }

    /**
        Usage : What value did _owner given access to _spender and how much its remaining
     */
    function allowance(address _owner, address _spender) constant returns (uint remaining) {
        return allowances[_owner][_spender];
    }

    /**
        Usage : The function which is called when you are sending the token (_value) from some one's behalf
     */
    function transferFrom(address _from, address _to, uint _value) returns (bool success) {
        if(_value <= 0 ) return false;
        if(balances[_from] < _value) return false;
        if(balances[_to] + _value < balances[_to]) return false;
        if(allowances[_from][msg.sender] < _value) return false;
        balances[_from] -= _value;
        balances[_to] += _value;
        allowances[_from][msg.sender] -= _value; 
        Transfer(_from, _to, _value);
        return true;
    }











       
}