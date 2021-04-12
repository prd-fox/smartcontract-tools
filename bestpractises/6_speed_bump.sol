pragma solidity 0.8.1;

contract SpeedBump {

    address owner;

    struct Withdrawal {
        uint amount;
        uint requestedAt;
    }

    mapping (address => uint) balances;
    mapping (address => Withdrawal) withdrawals;

    uint constant WAIT_PERIOD = 7 days;

    constructor() {
        owner = msg.sender;
    }

    function deposit() public payable {
        bool isRequestingWithdrawl = withdrawals[msg.sender].amount > 0;

        if (!isRequestingWithdrawl) {
            balances[msg.sender] += msg.value;
        }
    }

    function requestWithdrawal() public {
        uint withdrawAmount = balances[msg.sender];

        if (withdrawAmount > 0) {
            balances[msg.sender] = 0;
            withdrawals[msg.sender] = Withdrawal({ amount: withdrawAmount, requestedAt: block.timestamp });
        }
    }

    function withdraw() public {
        bool isRequestingWithdrawl = withdrawals[msg.sender].amount > 0;
        bool isAfterWaitPeriod = block.timestamp > withdrawals[msg.sender].requestedAt + WAIT_PERIOD;

        if(isRequestingWithdrawl && isAfterWaitPeriod ) {
            uint amount = withdrawals[msg.sender].amount;
            withdrawals[msg.sender].amount = 0;
            (bool success, ) = msg.sender.call{value: amount}("");
            require(success);
        }
    }

    function cancelWithdrawl(address _targetToCancel) external {
        require(owner == msg.sender);

        bool isRequestingWithdrawl = withdrawals[_targetToCancel].amount > 0;

        if (isRequestingWithdrawl) {
            balances[msg.sender] = withdrawals[_targetToCancel].amount;
            withdrawals[msg.sender].amount = 0;
        }
    }
}