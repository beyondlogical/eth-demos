pragma solidity ^0.4.24;

contract Record {
    address owner;

    uint public storedNumber;
    
    event Recorded(address, uint, uint);
    
    constructor(uint _storedNumber ) public payable {
        owner = msg.sender;
        storedNumber = _storedNumber;
        emit Recorded(msg.sender, _storedNumber, msg.value);
    }

    function update(uint _storedNumber) public payable onlyOwner {
        //require(msg.sender == owner, "Operation not allowed");
        storedNumber = _storedNumber;
        emit Recorded(msg.sender, _storedNumber, msg.value);
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Access denied");
        _;
    }

}
