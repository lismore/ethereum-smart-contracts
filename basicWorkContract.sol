pragma solidity ^0.4.7;

contract BasicWork{
    /* Define variable owner of the type address*/
    address owner;
    
    /* Define jobidentifer of type string */
    string public jobidentifer;
    
    /* Define client address of type address */
    address public client;
    
    /* Define worker address of type address */
    address public worker;
    
    uint256 value;
    
    mapping (address => uint) public balances;
    
    // Events allow light clients to react on
    // changes efficiently.
    event Pay(address from, address to, uint amount );
    
    function send(address receiver, uint amount) {
        if (balances[msg.sender] < amount) return;
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        return Pay(msg.sender, receiver, amount);
    }
    
    /* Contract constructor for basic work smart contract */
    constructor(string jobId, address clientAddress, address workerAddress) payable{
        jobidentifer = jobId;
        client = clientAddress;
        worker = workerAddress;
    }
    
    /* Returns the value of WORK locked in contract */
    function contractBalance() constant returns (uint256 amount){ return this.balance; }
    
    /* this function is executed at initialization and sets the owner of the contract */
    function setOwner() private { owner = msg.sender; }
    
     /* Function to recover the funds on the contract */
    function KillRecoverDispute() public { if (msg.sender == owner) selfdestruct(owner); }
    
    /* functino setClientAddress */
    function setClientAddress(address clientAddress) private { client = clientAddress; }
    
    /* function setWorkerAddress */
    function setWorkerAddress(address workerAddress) private { worker = workerAddress; }
    
    function claimWork() returns(bool success) { 
        uint256 bal = contractBalance();
        
        send(worker,bal ); return true; }

}
