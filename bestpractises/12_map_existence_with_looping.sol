pragma solidity ^0.8.0;

contract ERC20Basic {

    string public constant name = "ERC20Basic";
    string public constant symbol = "BSC";
    uint8 public constant decimals = 18;
    uint256 public totalSupply;

    event NotificationOfBalance(address indexed, uint);


    mapping(address => uint256) balances;
    address[] allAccounts;

    mapping(address => bool) public hasWallet;


    constructor(uint256 total) {
        totalSupply = total;
        register();
        balances[msg.sender] = totalSupply;
    }

    function register() public {
        hasWallet[msg.sender] = true;
        allAccounts.push(msg.sender);
    }

    function balanceOf(address tokenOwner) public view returns (uint) {
        return balances[tokenOwner];
    }

    function transfer(address receiver, uint numTokens) public returns (bool) {
        require(numTokens <= balances[msg.sender]);
        require(hasWallet[receiver]);

        balances[msg.sender] = balances[msg.sender] - numTokens;
        balances[receiver] = balances[receiver] + numTokens;
        return true;
    }


    function notify() public {
        for(uint i = 0; i<allAccounts.length; i++) {
            performTask(allAccounts[i]);
        }
    }

    function performTask(address walletHolder) public {
        emit NotificationOfBalance(walletHolder, walletHolder);
    }

}
