pragma solidity 0.8.1;

contract PushAuction {

    address highestBidder;
    uint highestBid;

    function bid() payable {
        require(msg.value >= highestBid);

        if (highestBidder != address(0)) {
            (bool success, ) = highestBidder.call{value: highestBid}("");
            require(success);
        }

        highestBidder = msg.sender;
        highestBid = msg.value;
    }

}