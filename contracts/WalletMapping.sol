// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract WalletMapping
{
    mapping(address => uint) public balanceReceived;

    function depositMoney() public payable
    {
        balanceReceived[msg.sender] += msg.value;
    }

    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }

    function getAccBal() public view returns(uint){
        return balanceReceived[msg.sender];
    }

    function withDrawMonaey(address payable _to, uint _amount) public {
        require(balanceReceived[msg.sender] >= _amount, "Not Sufficient Balance");
        balanceReceived[msg.sender]  -= _amount;
        _to.transfer(_amount);
    }
}