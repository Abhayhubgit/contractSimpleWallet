 // SPDX-License-Identifier: MIT
 pragma solidity ^0.5.0 ;
  import "./Ownable.sol" ;

  contract Allowance is Ownable {
       mapping(address => uint) public allowance ; 

       event AllowanceChnaged(address indexed _forWho , address indexed _fromWhom , uint _oldAmount , uint _newAmount) ;

     function addAlowance(address payable _who , uint _amount) public onlyOwner {
         emit AllowanceChnaged(_who , msg.sender , allowance[_who] , _amount);
         allowance[_who] = _amount ;
     }
     
     modifier ownerOrAllowed(uint  _amount) {
         require(isOwner() || allowance[msg.sender] >= _amount ,"You are not allowed ");
         _;
     }
   
    //// Reducing allowance amount
    function reduceAllowance(address _who , uint _amount) internal {
        emit AllowanceChnaged(_who , msg.sender , allowance[_who], allowance[_who]- _amount) ;
         allowance[_who] -= _amount ;
    }

  }