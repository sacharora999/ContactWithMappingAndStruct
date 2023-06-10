// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract MappingStructExample
{
    struct Trasactions
    {
        uint amount;
        uint timestamp;
    }
    struct Balance
    {
        uint totalBalance;
        uint numDeposits;
        mapping(uint => Trasactions) deposits;
        uint numWithdrals;
        mapping(uint => Trasactions) withdrawls;
    }

    mapping(address => Balance) public balances;

    function getTransaction(address _from, uint _numDeposits ) public view returns(Trasactions memory)
    {
        return balances[_from].deposits[_numDeposits];
    }
    
    function depositMoney() public payable {

        balances[msg.sender].totalBalance += msg.value;
        Trasactions memory trans = Trasactions(msg.value, block.timestamp);
        balances[msg.sender].deposits[balances[msg.sender].numDeposits] = trans;
        balances[msg.sender].numDeposits++;
    }

    function withdrawMoney(address payable _to, uint _amount) public payable {

        balances[msg.sender].totalBalance -= _amount;
        Trasactions memory trans = Trasactions(_amount, block.timestamp);
        balances[msg.sender].withdrawls[balances[msg.sender].numWithdrals] = trans;
        balances[msg.sender].numWithdrals++;
        _to.transfer(_amount);
    }

}