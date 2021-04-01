pragma solidity ^0.7.3;

contract StackTraceContract {

    function fail(string memory failreason) public pure {
        return revert(failreason);
    }

}
