//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/proxy/Clones.sol";
import "./User.sol";

contract Helper {
    address public implementation;
    address public createdProxy;

    constructor(address _implementation) {
        implementation = _implementation;
    }

    function createStorage() public returns (address) {
        //how to call openzeppelin? maybe like this?
        // address proxy = clone(implementation);
        address proxy = Clones.clone(implementation);
        createdProxy = proxy;
        User(implementation).getProxyAddress(createdProxy);
        //this function might initialize the proxy contract
        //  User(createdProxy).initialize();

        return proxy;
    }

    function returnAddress() public {
        User(implementation).getProxyAddress(createdProxy);
    }
}
