//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

contract Vault {
    address public owner;
    uint public value;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier priceRequired() {
        require(msg.value == 1e18 / 2);
        _;
    }

    function deposit() public payable priceRequired {
        value += msg.value;
    }

    function withdraw(uint amount) public onlyOwner {
        require(amount <= value);
        payable(msg.sender).transfer(amount);
        value -= amount;
    }

    function balance() public view returns (uint) {
        return address(this).balance;
    }
}
