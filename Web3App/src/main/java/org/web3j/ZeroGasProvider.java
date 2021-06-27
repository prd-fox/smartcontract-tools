package org.web3j;

import org.web3j.tx.gas.StaticGasProvider;

import java.math.BigInteger;

public class ZeroGasProvider extends StaticGasProvider {
    public static final BigInteger GAS_LIMIT = BigInteger.valueOf(9_000_000);
    public static final BigInteger GAS_PRICE = BigInteger.valueOf(0L);

    public ZeroGasProvider() {
        super(GAS_PRICE, GAS_LIMIT);
    }
}
