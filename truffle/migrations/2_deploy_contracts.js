const ConvertLib = artifacts.require("ConvertLib");
const MetaCoin = artifacts.require("MetaCoin");

module.exports = function(deployer, network, accounts) {
  console.log(network);
  console.log(accounts);

  deployer.deploy(ConvertLib);
  deployer.link(ConvertLib, MetaCoin);

  deployer.deploy(MetaCoin, {privateFor: ["ROAZBWtSacxXQrOe3FGAqJDyJjFePR5ce4TSIzmJ0Bc="]});

  console.log("sss");
};
