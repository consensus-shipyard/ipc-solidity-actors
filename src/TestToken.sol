// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ERC20Token is ERC20 {
    constructor() ERC20("IPC", "IPC")
    {
        _mint(msg.sender, 1_000_000_000 * 10**uint256(decimals()));
    }
}
