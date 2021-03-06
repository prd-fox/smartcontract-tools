const fs = require("fs");

let name = process.argv[2];

const contract = JSON.parse(fs.readFileSync("./build/contracts/" + name + ".json").toString());

name = "YourContract";

fs.writeFileSync("../scaffold/packages/react-app/src/contracts/" + name + ".abi.js", 'module.exports = ' + JSON.stringify(contract.abi) + ';')
fs.writeFileSync("../scaffold/packages/react-app/src/contracts/" + name + ".address.js", 'module.exports = "' + contract.networks["31337"].address + '";')
fs.writeFileSync("../scaffold/packages/react-app/src/contracts/" + name + ".bytecode.js", 'module.exports = "' + contract.deployedBytecode + '";')
