const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("GreetCounter", function() {

  it("Should count properly", async function() {
    const Counter = await ethers.getContractFactory("GreetCounter");
    const counter = await Counter.deploy();
    await counter.deployed();

    await counter.countGreeting("Hola, mundo!");
    expect(await counter.getCount("Hola, mundo!")).to.equal(1);

    await counter.countGreeting("Hola, mundo!");
    expect(await counter.getCount("Hola, mundo!")).to.equal(2);
  });

});

