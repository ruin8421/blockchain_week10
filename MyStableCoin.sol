// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyStableCoin is ERC20, Ownable {
    constructor() ERC20("My Test Stablecoin", "MYST") Ownable(msg.sender) {
        // 테스트를 위해 본인 계정에 10,000개 발행 (소수점 18자리)
        _mint(msg.sender, 10000 * 10 ** decimals());
    }

    // 필요할 때 더 찍어낼 수 있는 기능 (테스트용)
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}