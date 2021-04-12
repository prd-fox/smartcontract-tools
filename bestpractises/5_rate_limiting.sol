pragma solidity 0.8.1;

contract RateLimiter {

    address lastUser;
    uint8 count;


    mapping(string => string) userdata;

    modifier rateLimited(address user) {
        if (lastUser != msg.sender) {
            lastUser = msg.sender;
            count = 0;
        }

        count++;
        require(count < 5);

        _;
    }

    function addUpdateUserData(string memory username, string memory data) rateLimited(msg.sender) external {
        userdata[username] = data;
    }

}