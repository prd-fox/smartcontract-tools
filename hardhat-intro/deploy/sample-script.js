module.exports = async ({
                            getNamedAccounts,
                            deployments,
                            getChainId,
                            getUnnamedAccounts,
                        }) => {
    const {deploy} = deployments;
    const {deployer} = await getNamedAccounts();

    let counter = await deploy('GreetCounter', {
        from: deployer,
        gasLimit: 4000000,
        args: [],
    });

    console.log("Deployed counter at " + counter.address);

    // the following will only deploy "GenericMetaTxProcessor" if the contract was never deployed or if the code changed since last deployment
    let greeter = await deploy('Greeter', {
        from: deployer,
        gasLimit: 4000000,
        args: ["Initial greeting", counter.address],
    });

    console.log("Deployed greeter at " + greeter.address);
};