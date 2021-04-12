pragma solidity 0.8.1;

contract DiceGame {

    enum Stages { Registering, Rolling, Finished }

    Stages public currentStage = Stages.Registering;

    mapping(address => int) rolls;
    mapping(address => bool) registrations;

    address highestRoller = address(0x0);
    int highestRoll = -1;

    function register(address _toRegister) public {
        require(currentStage == Stages.Registering);

        registrations[_toRegister] = true;
    }

    function makeRoll(address _toRoll) public {
        require(currentStage == Stages.Rolling);
        require(registrations[_toRoll]);

        int roll = int(block.timestamp % 100);

        rolls[_toRoll] = roll;

        if (roll > highestRoll) {
            highestRoll = roll;
            highestRoller = _toRoll;
        }

        if (roll == 99) {
            nextStage();
        }
    }

    function declareWinner() public view returns (address) {
        require(currentStage == Stages.Finished);

        return highestRoller;
    }

    function transition() public {
        nextStage();
    }

    function nextStage() internal {
        require(currentStage != Stages.Finished);
        currentStage = Stages(uint(currentStage) + 1);
    }

}