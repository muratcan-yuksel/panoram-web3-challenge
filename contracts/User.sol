//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;
import "./Helper.sol";
import "./Vault.sol";
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract User is Initializable, Ownable {
    address public contractOwner;
    uint public value;
    address public proxyAddress;
    uint256 public currentLevel;
    uint256 public userCount;
    address[] public usersArray;
    uint256 fundPriceInWei;

    // constructor() {
    function initialize() public initializer {
        //  owner = msg.sender;
        currentLevel = 1;
        userCount = 0;
        fundPriceInWei = 44607301010845152.0000;
    }

    modifier userCountIsLessThanNine() {
        require(userCount < 9);
        _;
    }

    modifier userCountIsNine() {
        require(userCount == 9);
        _;
    }
    modifier maxLevel() {
        require(currentLevel < 10);
        _;
    }

    function returnLevel() public view returns (uint256) {
        return currentLevel;
    }

    function fund() public payable userCountIsLessThanNine {
        require(msg.value == fundPriceInWei);
        //vault address will be passed here
        payFeeToVault();
        // value += msg.value;
        userCount++;
    }

    function payFeeToVault(address _vault) internal {
        if (userCount % 3 == 0) {
            Vault(_vault).deposit{value: fundPriceInWei / 2}();
            value += fundPriceInWei / 2;
        }
        //else part doesn't work
        else {
            Vault(_vault).deposit{value: (fundPriceInWei / 100) * 30}();
            value += (fundPriceInWei / 100) * 70;
        }
    }

    //add a deposit function for the owner
    //because levelUp function takes money from the contract balance
    function levelUp(address _vault) public onlyOwner userCountIsNine maxLevel {
        Vault(_vault).deposit{value: 1e18 / 2}();
        currentLevel++;
        userCount = 0;
        value -= 1e18 / 2;
    }

    function withdraw(uint amount) public onlyOwner {
        require(amount <= value);
        payable(msg.sender).transfer(amount);
        value -= amount;
    }

    function balance() public view returns (uint) {
        return address(this).balance;
    }

    function callCreateStorage(address _helper) public onlyOwner {
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
