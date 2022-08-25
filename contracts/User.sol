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
    uint256 public inviteeCount;
    address[] public inviteeArray;
    //use constant to save some gas
    uint256 public constant FUND_PRICE_IN_WEI = 44607301010845152.0000;

    // constructor
    function initialize() public initializer {
        currentLevel = 1;
        inviteeCount = 0;
    }

    modifier inviteeCountIsLessThanNine() {
        require(inviteeCount < 9);
        _;
    }

    modifier inviteeCountIsNine() {
        require(inviteeCount == 9);
        _;
    }
    modifier maxLevel() {
        require(currentLevel < 10);
        _;
    }

    function returnLevel() public view returns (uint256) {
        return currentLevel;
    }

    //invitees need to call this function and pay 0.25 BSC
    function fund() public payable inviteeCountIsLessThanNine {
        require(msg.value == FUND_PRICE_IN_WEI);
        //call the divider function
        //vault address on goerli etherscan
        payFeeToVault(0xE75701A75236B27Bb452A764bc1222F889F80B82);
        inviteeCount++;
        inviteeArray.push(msg.sender);
    }

    //divider function, changes the amount of the user and the vault receives in every 3 invitee
    function payFeeToVault(address _vault) internal {
        if (inviteeCount % 3 == 0) {
            Vault(_vault).deposit{value: FUND_PRICE_IN_WEI / 2}();
            value += FUND_PRICE_IN_WEI / 2;
        } else {
            Vault(_vault).deposit{value: (FUND_PRICE_IN_WEI / 100) * 30}();
            value += (FUND_PRICE_IN_WEI / 100) * 70;
        }
    }

    //add a deposit function for the owner
    //because levelUp function takes money from the contract balance
    //so the user might want to add some money to the contract
    function deposit() public payable onlyOwner {
        value += msg.value;
    }

    //once the invitee count reaches 9, the user has to pay half and ether to the vault to level up
    //with maxLevel modifier, the user can't level up more than 10
    function levelUp(address _vault)
        public
        onlyOwner
        inviteeCountIsNine
        maxLevel
    {
        Vault(_vault).deposit{value: 1e18 / 2}();
        currentLevel++;
        inviteeCount = 0;
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

    //call createStorage function in Helper.sol contract to create a shallow copy of this contract
    function callCreateStorage(address _helper) public onlyOwner {
        Helper(_helper).createStorage();
    }

    //get the address of the created proxy contract
    //this function is called from the Helper.sol contract
    //will add this address into an array of proxy addresses
    function getProxyAddress(address _proxyAdress) public {
        proxyAddress = _proxyAdress;
    }
}
