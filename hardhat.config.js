require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-ethers");
require("@openzeppelin/hardhat-upgrades");

require("@nomiclabs/hardhat-waffle");
require("dotenv").config();

module.exports = {
  solidity: "0.8.10",
  networks: {
    goerli: {
      url: `${process.env.ALCHEMY_GOERLI_URL}`,
      accounts: [`${process.env.MY_PRIVATE_KEY}`],
    },
  },
};
