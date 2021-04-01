const { expect } = require("chai");

describe("Counter", function() {

    it("Should produce a stack trace", async function() {
        const Counter = await ethers.getContractFactory("GreetCounter");
        const counter = await Counter.deploy();
        await counter.deployed();


        for(let i=1; i<6; i++) {
            await counter.countGreeting("Hola, mundo!");
            expect(await counter.getCount("Hola, mundo!")).to.equal(i);
        }

        await counter.countGreeting("Hola, mundo!");

        // await greeter.setGreeting("Hola, mundo!");
        // expect(await greeter.greet()).to.equal("Hola, mundo!");
    });

});