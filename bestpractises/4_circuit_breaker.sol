pragma solidity 0.8.1;

contract CircuitBreaker {

    event ShowInput(uint256 userData);

    bool halted;
    address owner;

    constructor() {
        owner = msg.sender;
        halted = false;
    }

    function haltProcessing() external {
        require(owner == msg.sender);
        halt();
    }

    function resumeProcessing() external {
        require(owner == msg.sender);
        halted = false;
    }

    function doSomething(uint256 input) public {

        if (input > 100) {
            halt();
            return;
        }

        emit ShowInput(input);
    }

    function halt() internal {
        halted = true;
    }

}
