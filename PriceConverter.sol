//SPDX-License-Identifier:MIT
pragma solidity ^0.8.7;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter{
    function getPrice(AggregatorV3Interface priceFeed) internal view returns(uint256){
          (,int256 price,,,)=priceFeed.latestRoundData();
    return uint256(price*1e10);
    }

    function getConversionRate(uint256 eth_Amount, AggregatorV3Interface priceFeed)internal view returns(uint256){
       uint256 ethPrice = getPrice(priceFeed);
       uint256 ethAmountInUSD = (ethPrice* eth_Amount)/10**18;
       return ethAmountInUSD;
    }
}

