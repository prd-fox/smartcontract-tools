package org.web3j;

import org.web3j.crypto.Credentials;
import org.web3j.crypto.ECKeyPair;
import org.web3j.crypto.Keys;
import org.web3j.generated.contracts.HelloWorld;
import org.web3j.protocol.Web3j;
import org.web3j.protocol.http.HttpService;
import org.web3j.quorum.Quorum;
import org.web3j.quorum.tx.ClientTransactionManager;
import java.io.InputStream;

import java.util.List;

public class Web3App {

    public static void main(String[] args) throws Exception {
        String nodeUrl = "http://localhost:8545";

        ECKeyPair ecKeyPair = Keys.createEcKeyPair();
        Credentials credentials = Credentials.create(ecKeyPair);
        System.err.println(credentials.getAddress());

        Web3j web3j = Web3j.build(new HttpService(nodeUrl));

        System.out.println("Deploying HelloWorld contract ...");

//        HelloWorld helloWorld = HelloWorld
//                .deploy(web3j, credentials, new ZeroGasProvider(), "Hello Blockchain World!")
//                .send();

        Quorum quorum = Quorum.build(new HttpService(nodeUrl));
        String s = quorum.ethAccounts().send().getAccounts().get(0);

        ClientTransactionManager privateWeb3j = new ClientTransactionManager(
                quorum, s, null, null//List.of("ROAZBWtSacxXQrOe3FGAqJDyJjFePR5ce4TSIzmJ0Bc=")
        );
        HelloWorld helloWorld = HelloWorld
                .deploy(quorum, privateWeb3j, new ZeroGasProvider(), "Hello Blockchain World!")
                .send();

        System.out.println("Contract address: " + helloWorld.getContractAddress());
        System.out.println("Greeting method result: " + helloWorld.greeting().send());

        String addressFile = String.format("module.exports = \"%s\";", helloWorld.getContractAddress());
        String bytecodeFile = String.format("module.exports = \"%s\";", helloWorld.getContractBinary());

        System.out.println("PETER: " + helloWorld.getContractBinary());

        String ret = readSolBin("solidity", HelloWorld.class);
        System.out.println(ret);

    }

    public static String readSolBin(String solDir, Class<?> solClazz) throws Exception {
        InputStream q = solClazz.getResourceAsStream(String.format("/%s/%s.abi", solDir, solClazz.getSimpleName()));
        return new String(q.readAllBytes());
        //return StreamUtils.copyToString(solClazz.getResourceAsStream(String.format("/%s/%s.bin", solDir, solClazz.getSimpleName())), Charset.defaultCharset());
    }
}