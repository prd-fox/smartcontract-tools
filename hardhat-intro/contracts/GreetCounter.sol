//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.7.3;

import "./StackTraceContract.sol";
import "hardhat/console.sol";

contract GreetCounter {

    mapping(string => uint) greetingCounter;

    StackTraceContract s;

    constructor() {
        s = new StackTraceContract();
    }

    function countGreeting(string memory _greeting) public returns (uint) {
        uint count = ++greetingCounter[_greeting];
        console.log(_greeting, "said", count, "times");
        if(count > 5) {
            s.fail("Reused saying too much!");
        }
        return count;
    }

    function getCount(string memory _greeting) public view returns (uint) {
        return greetingCounter[_greeting];
    }
}
