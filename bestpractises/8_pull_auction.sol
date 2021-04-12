pragma solidity 0.8.1;

contract PullAuction {

    address highestBidder;
    uint highestBid;

    mapping(address => uint) refunds;

    function bid() payable external {
        require(msg.value >= highestBid);

        if (highestBidder != address(0)) {
            refunds[highestBidder] += highestBid;
        }

        highestBidder = msg.sender;
        highestBid = msg.value;
    }

    function withdrawRefund() external {
        uint refund = refunds[msg.sender];
        refunds[msg.sender] = 0;

        (bool success, ) = highestBidder.call{value: refund}("");
        require(success);
    }

}