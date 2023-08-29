// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity 0.8.19;

import "openzeppelin-contracts/token/ERC20/ERC20.sol";
import "openzeppelin-contracts/access/Ownable.sol";

import "forge-std/console.sol";

contract DummyERC20 is ERC20, Ownable {
    uint256 public currentSupply = 0;

    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _initialSupply
    ) Ownable(msg.sender) ERC20(_name, _symbol) {
        _mint(owner(), _initialSupply);
    }

    function mint(address _to, uint256 _amount) public onlyOwner {
        _mint(_to, _amount);
    }
    function transfer(address _to,uint256 _amount) override public returns (bool) {
        console.log(">>>> transfer to:", _to);
        console.log(">>>> transfer amount:", _amount);
        if (_amount == 1) {
            //revert("ddddddd");
        }
        return super.transfer(_to, _amount);
    }
}
