pragma solidity ^0.4.24;

contract DB {
    address owner;

    struct Record {
        uint id;
        address owner;
        string data;
    }
    
    mapping (uint => Record) records;
    uint public recordCount = 0;

    event Setup(address);
    event Created(address, uint, string);
    event Updated(address, uint, string);
    
    constructor( ) public {
        owner = msg.sender;

        emit Setup(msg.sender);
    }

    function create(string _data) public {
        Record storage record = records[recordCount];
        record.data = _data;

        record.id = recordCount++;  // starts ids at 0
        //record.id = ++recordCount; // starts ids at 1
        record.owner = msg.sender;
        record.data = _data;

        emit Created(msg.sender, record.id, record.data);
    }

    function update(uint _id, string _data) public onlyOwner(_id) {
        Record storage record = records[_id];
        record.data = _data;
        
        emit Updated(msg.sender, record.id, record.data);
    }
    
    function getRecord(uint _id) public view returns (string) {
        Record storage record = records[_id];
        return (record.data);
    }
    
    modifier onlyOwner(uint _id) {
        require(msg.sender == records[_id].owner, "Access denied");
        _;
    }

}
