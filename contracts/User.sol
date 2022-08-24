//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

contract User {
    address public owner;
    uint public value;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function receive() public payable {
        value += msg.value;
    }

    function receive() public payable onlyOwner {
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
