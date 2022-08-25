//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;
import "./Helper.sol";
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";

contract User is Initializable {
    address public owner;
    uint public value;
    address public proxyAddress;

    // constructor() {
    function initialize() public initializer {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function receive() public payable {
        value += msg.value;
    }

    //might use this function so that only the user can use this very function to send money to his own contract
    // function deposit() public payable onlyOwner {
    //     value += msg.value;
    // }

    function withdraw(uint amount) public onlyOwner {
        require(amount <= value);
        payable(msg.sender).transfer(amount);
        value -= amount;
    }

    function balance() public view returns (uint) {
        return address(this).balance;
    }

    function callCreateStorage(address _helper) public {
        Helper(_helper).createStorage();
    }

    // function callReturnAddress(address _helper) public {
    //     Helper(_helper).returnAddress();
    // }

    //get the address of the created proxy contract
    //this function is called from the Helper.sol contract
    //will add this address into an array of proxy addresses
    function getProxyAddress(address _proxyAdress) public {
        proxyAddress = _proxyAdress;
    }
}
