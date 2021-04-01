//SPDX-License-Identifier: Unlicense
pragma solidity ^0.7.0;

import "hardhat/console.sol";
import "./GreetCounter.sol";

contract Greeter {
  string greeting;

  GreetCounter counter;

  constructor(string memory _greeting, GreetCounter _counter) {
    console.log("Deploying a Greeter with greeting:", _greeting);
    counter = _counter;
    setGreeting(_greeting);
  }

  function greet() public view returns (string memory) {
    return greeting;
  }

  function setGreeting(string memory _greeting) public {
    console.log("Changing greeting from '%s' to '%s'", greeting, _greeting);
    uint count = counter.countGreeting(greeting);
    console.log("Counted this greeting", count, "times");
    greeting = _greeting;
  }
}
