// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./Allowance.sol";

contract FundWallet is Allownance {
    event MoneySent(address _to,uint _amount);
    event MoneyFrom(address _from,uint _amount);
   function withdrawMoney(address payable _to,uint _amount) public isOwnerOrAllowance(_amount){

    if(!isOwner()){
        reduceAllowance(msg.sender, _amount);
    }
    _to.transfer(_amount);
    emit MoneySent(_to, _amount);
   }
   receive() external payable{
        // token is received money
        emit MoneyFrom(msg.sender,msg.value);
    }
}