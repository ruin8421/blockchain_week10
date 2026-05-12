// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract PaymentProcessor {
    address public admin;
    IERC20 public stablecoin;

    event PaymentDone(address payer, uint256 amount, uint256 paymentId, uint256 date);

    constructor(address _admin, address _stablecoin) {
        admin = _admin;
        stablecoin = IERC20(_stablecoin);
    }

    function pay(uint256 amount, uint256 paymentId) external {
        // 1. 사용자가 이 컨트랙트에 토큰 사용 승인(Approve)을 먼저 해야 함
        // 2. 사용자 계좌에서 관리자 계좌로 토큰 전송
        require(stablecoin.transferFrom(msg.sender, admin, amount), "Transfer failed");
        
        emit PaymentDone(msg.sender, amount, paymentId, block.timestamp);
    }
}