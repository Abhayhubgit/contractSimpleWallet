 // SPDX-License-Identifier: MIT
 pragma solidity ^0.5.0 ;
 import "./Allowance.sol";
 
 contract  SimpleWallet is Allowance {

     event MoneySent(address indexed _Beneficiary , uint _amount) ; 
     event MoneyReceived(address indexed _fromWho , uint _amount) ;

    //// WithdrwaMoney All

    function withdrawMoney(address payable _to , uint  _amount)  public ownerOrAllowed(_amount)  {
          require(_amount <= address(this).balance , "There are not enough funds stored in the Smart Contracts") ;
        
         if(!isOwner()){
             reduceAllowance(msg.sender , _amount);
         }
         emit MoneySent(_to , _amount) ;
          _to.transfer(_amount) ;
    }

    function renounceOwnership() public onlyOwner {
        revert("Can't renounce Ownership here");
    }
    //// Fallback functon Contract receive money here 
    function deposit()  external  payable {
         emit MoneyReceived(msg.sender , msg.value) ; 
    }

         
     
 }