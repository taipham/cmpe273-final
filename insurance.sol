pragma solidity ^0.4.18;

contract InsuranceContract {
    address insurer;

    
    struct buyer {
        string name;
        uint32 age;
        uint32 baseCost;
        uint32 totalRebate;
        uint monthlySendDate;
        string insureProof;
    }
  
    mapping (address => buyer) buyers;
    address[] buyerAddresses;
    

    function InsuranceContract() public {
        insurer = msg.sender;
    }
    

    function regInsurance(string _name, uint32 _age, uint32 _baseCost) public returns (string) {
        var aBuyer = buyers[msg.sender];
        aBuyer.name = _name;
        aBuyer.age = _age;
        aBuyer.baseCost = _baseCost;
        aBuyer.totalRebate = 0;
        aBuyer.monthlySendDate = now;
        // randomize a string here => hash the string => store the hash here for now.
        aBuyer.insureProof = "random string hash";
        buyerAddresses.push(msg.sender);
        return aBuyer.insureProof;
    }
  
    function sendMonthly(uint _steps) public payable{
        calculateRebate(_steps);
    }
  
    function getMyInfo() public view returns (string, uint, uint, uint, uint, string) {
        var info = buyers[msg.sender];
        return (info.name, info.age, info.baseCost, info.totalRebate, info.monthlySendDate, info.insureProof);
    }
  
    function calculateRebate(uint steps) private {
        uint32 rebate = 0;
        if (steps > 10000) {
            rebate = 1;
        }
        buyers[msg.sender].totalRebate += rebate;
    }

//   function getRebateValue() public constant returns (uint) {
//       return pendingWithdrawals[msg.sender];
//   }

//   function withdraw() {
//       uint amount = pendingWithdrawals[msg.sender];
//       // Remember to zero the pending refund before
//       // sending to prevent re-entrancy attacks
//       pendingWithdrawals[msg.sender] = 0;
//       msg.sender.transfer(amount);
//   }
}