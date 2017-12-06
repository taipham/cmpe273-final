pragma solidity ^0.4.18;

contract InsuranceContract {
    address insurer;
    
    uint totalRebateofAll;
    
    struct buyer {
        string name;
        uint age;
        uint baseCost;
        uint totalRebate;
        uint monthlySendDate;
        string insureProof;
    }
  
    mapping (address => uint) buyerRebate;
    mapping (address => buyer) buyers;
    
    modifier notInsurer() {
        require(msg.sender != insurer);
        _;
    }
    
    modifier isInsurer() {
        require(msg.sender == insurer);
        _;
    }
    
    function InsuranceContract() public {
        insurer = msg.sender;
    }
    
    function regInsurance(string _name, uint _age, uint _baseCost) public notInsurer returns (string) {
        var aBuyer = buyers[msg.sender];
        aBuyer.name = _name;
        aBuyer.age = _age;
        aBuyer.baseCost = _baseCost;
        aBuyer.totalRebate = 0;
        // randomize a string here => hash the string => store the hash here for now.
        aBuyer.insureProof = "random string hash";
        return aBuyer.insureProof;
    }
  
    function sendMonthly(uint _steps) public notInsurer payable{
        buyers[msg.sender].monthlySendDate = now;
        calculateRebate(_steps);
        
    }
  
    function getMyInfo() public view notInsurer returns (string, uint, uint, string) {
        var info = buyers[msg.sender];
        return (info.name, info.age, info.monthlySendDate, info.insureProof);
    }
    
    function getRebate() public view notInsurer returns(uint) {
        //require(msg.sender != insurer);
        return buyerRebate[msg.sender];
    }
  
    function calculateRebate(uint steps) private {
        uint rebate = 0;
        if (steps > 10000) {
            rebate = 100000000000000000;
        }
        buyers[msg.sender].totalRebate += rebate;
        buyerRebate[msg.sender] = buyers[msg.sender].totalRebate;
        totalRebateofAll += rebate;
    }
    
    function withdraw() public notInsurer{
        uint amount = buyers[msg.sender].totalRebate;
        buyers[msg.sender].totalRebate = 0;
        buyerRebate[msg.sender] = 0;
        totalRebateofAll -= amount;
        msg.sender.transfer(amount);
    }
    
    function insurerWithdraw() public isInsurer returns(uint){
        uint amt = this.balance - totalRebateofAll;
        insurer.transfer(amt);
        return amt;
    }
    
    function getBal() view returns(uint){
        return this.balance;
    }
}