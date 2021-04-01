const { expect } = require("chai");

describe("Greeter", function() {

  it("Should return the new greeting once it's changed", async function() {
    const Counter = await ethers.getContractFactory("GreetCounter");
    const counter = await Counter.deploy();
    await counter.deployed();

    const Greeter = await ethers.getContractFactory("Greeter");
    const greeter = await Greeter.deploy("Hello, world!", counter.address);

    await greeter.deployed();
    expect(await greeter.greet()).to.equal("Hello, world!");

    await greeter.setGreeting("Hola, mundo!");
    expect(await greeter.greet()).to.equal("Hola, mundo!");

    await greeter.setGreeting("Hola, mundo!");
    expect(await greeter.greet()).to.equal("Hola, mundo!");
  });

  it("Some other test", async function() {
    const Counter = await ethers.getContractFactory("GreetCounter");
    const counter = await Counter.deploy();
    await counter.deployed();

    const Greeter = await ethers.getContractFactory("Greeter");
    const greeter = await Greeter.deploy("Hello, world!", counter.address);

    await greeter.deployed();
    expect(await greeter.greet()).to.equal("Hello, world!");

    await greeter.setGreeting("Hola, mundo!");
    expect(await greeter.greet()).to.equal("Hola, mundo!");

    await greeter.setGreeting("Hola, mundo!");
    expect(await greeter.greet()).to.equal("Hola, mundo!");
  });

});

