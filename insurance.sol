pragma solidity ^0.4.18;

contract InsuranceContract {
    
  string fName;
  uint age;
  uint value = 1000;
   
  mapping (address => uint) pendingWithdrawals;

  function setBuyer(string _fName, uint _age, uint _value) public {
      fName = _fName;
      age = _age;
      value = _value;
  }
   
  function getBuyer() public constant returns (string, uint, uint) {
      return (fName, age, value);
  }
  
  function calculateRebate(uint steps) public returns (uint) {
      uint rebate = 0;
      if (steps > 10000) {
          rebate = 1;
      }
      pendingWithdrawals[msg.sender] = rebate;
      return rebate;
  }  

  function getRebateValue() public constant returns (uint) {
      return pendingWithdrawals[msg.sender];
  }

  function () public payable {
 
  }

  function withdraw() {
      uint amount = pendingWithdrawals[msg.sender];
      // Remember to zero the pending refund before
      // sending to prevent re-entrancy attacks
      pendingWithdrawals[msg.sender] = 0;
      msg.sender.transfer(amount);
  }

}
