//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/proxy/Clones.sol";
import "./User.sol";

contract Helper {
    address public implementation;
    address public proxyAddress;

    constructor(address _implementation) {
        implementation = _implementation;
    }

    function createStorage() public returns (address) {
        address proxy = clone(implementation);
        createdProxy = proxy;
        User(implementation).getProxyAddress(createdProxy);
        return proxy;
    }

    function returnAddress() public {
        User(implementation).getProxyAddress(createdProxy);
    }
}
