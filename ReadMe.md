# [과제] Sepolia Testnet 기반 스테이블코인 결제 시스템 구현

## 1. 프로젝트 개요
이더리움 **Sepolia Testnet**을 활용하여 ERC-20 표준 스테이블코인을 발행하고, 스마트 컨트랙트 간의 상호작용(`Approve-TransferFrom` 패턴)을 통해 실제 결제가 이루어지는 DApp 환경을 구축함.

## 2. 시스템 설계 및 구성 요소

### 2.1 스마트 컨트랙트 아키텍처
본 시스템은 두 개의 핵심 컨트랙트로 구성됩니다.

1. **MyStableCoin (ERC-20)**
   - 가치를 $1로 가정한 테스트용 스테이블코인(`MYST`)입니다.
   - OpenZeppelin 라이브러리를 사용하여 보안성과 표준성을 확보했습니다.
2. **PaymentProcessor (결제 처리기)**
   - 사용자의 토큰 전송 권한을 위임받아 관리자(Admin)에게 대금을 전달합니다.
   - 결제 시마다 고유한 `PaymentID`를 이벤트로 기록하여 데이터 추적을 가능하게 합니다.



### 2.2 기술 스택
- **Smart Contract:** Solidity ^0.8.20
- **Library:** OpenZeppelin (ERC20, Ownable)
- **Frontend:** HTML5, Ethers.js (v5.7.2)
- **Wallet:** MetaMask (GIWA Sepolia Testnet)

## 3. 핵심 소스 코드

### 3.1 MyStableCoin.sol
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyStableCoin is ERC20, Ownable {
    constructor() ERC20("My Test Stablecoin", "MYST") Ownable(msg.sender) {
        _mint(msg.sender, 10000 * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}