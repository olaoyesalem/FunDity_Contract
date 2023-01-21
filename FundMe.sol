//SPDX-License-Identifier:MIT
pragma solidity ^0.8.7;

/**
 @title A contract for crowd funding
 @author Olaoye Salem
 @notice This contract is to demo a sample funding contract
 @dev This implements price feeds as our library
 */
 
contract CrowdFund{

address immutable i_owner;
uint256 constant MINIMUM_USD = 1e1*18;// 1 dollar
address [] public funders; 
mapping(address=>uint256) public addressToAmountFunded;

constructor(){
    i_owner = msg.sender;
}

modifier onlyOwner(){
    require(msg.sender==i_owner);
    _;
}
modifier sendError(){
require(msg.value>=MINIMUM_USD, "Send More Eth");
_;
}

    function Fund() public payable sendError  {
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender]+=msg.value;

}
    function withdraw()public onlyOwner{
        for(uint i=0; i<funders.length; i++){
            addressToAmountFunded[funders[i]]=0;
        }
        funders = new address[](0);
        (bool callSuccess, )=payable(msg.sender).call{value: address(this).balance}("");
            require(callSuccess,"call Failed");
    }

        
    function highestFunder() public returns(address){

    }

    receive() external payable{
        Fund();
    }
    fallback()external payable{
        Fund();
    }

}

