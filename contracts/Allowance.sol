// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Allownance is Ownable {
    mapping (address=>uint) public allownance;

    event AllownanceChanged (address indexed _forWho, address indexed _forWhom, uint _oldAmount, uint _newAmount); 
    using SafeMath for uint; 

    function isOwner() public view returns(bool){
        return owner() == msg.sender;    
    }
    
    modifier isOwnerOrAllowance(uint _amount){
        require(isOwner() || allownance[msg.sender] >= _amount,"You are not allowed");
        _;
    }

    function addAllowance(address _who,uint _amount) public isOwnerOrAllowance(_amount){
     
        emit AllownanceChanged(_who, msg.sender, allownance[_who], _amount);
     
        allownance[_who] = allownance[_who].add(_amount);
    }

    function reduceAllowance(address _who,uint _amount) public isOwnerOrAllowance(_amount){
     
        emit AllownanceChanged(_who, msg.sender, allownance[_who],  allownance[_who] - _amount);
     
        allownance[_who] = allownance[_who].sub(_amount);
    }

}