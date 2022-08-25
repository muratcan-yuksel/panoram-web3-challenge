# Explanation & caveats

I couldn't finish some of the tasks:

I couldn't get a binance test coin, so the contracts are deployed to goerli testnet. Here are the relevant info and links =>

```
`Vault.sol `on etherscan => https://goerli.etherscan.io/tx/0xbcf82a82082734f21b4a26f10297ab1457edcac86aac2109d07d1311a2831e00

Vault contract address => 0xE75701A75236B27Bb452A764bc1222F889F80B82

`User.sol` on etherscan =>https://goerli.etherscan.io/tx/0x7e6b2a43746842e78672fd819da73dd7ccb35dbdd545ad7df5849679e6b0b6d8

User contract address=> 0x8615Eea18015B729f2f6f8BA1c10eEBAAdC46677

`Helper.sol` on etherscan => https://goerli.etherscan.io/tx/0xd35f839a928dc249379afd89bd5509aedd88c1323dc24088b24a40b95cb06d49

Helper contract address=> 0xAE92F7a3d5Feb95a1D1956C1b190b1212Ec3A020

`shallow copy` on etherscan => https://goerli.etherscan.io/tx/0x80321aea051ab858c3214041931c6b0d18d660d93b1f84007d6a7ec34a89b735

shallow copy address => 0x8615Eea18015B729f2f6f8BA1c10eEBAAdC46677
```

I also couldn't use the Chainlink data feeds to convert from bcs to usd, for some reason AggregatorV3Interface was not working. So I manually entered the price of wei equal to 0.25 BSC at the time. It is saved as `44607301010845152.0000`

The project consist of 3 parts. There's the `vault`, which is the business owner's contract who gets the end money, the `User` that contains all the logic required, and the `helper` who meditates the system.

The idea is to create a shallow copy of the `User.sol` contrat using the ERC1167 standard. I used this standard to save gas. If everything goes alright, what it does is to create a small contract that delegates all the functions to the original contract. But it uses its own state, therefore the original contract's state remains unchanged.

This should be the behavior of the project if I managed to implement it correctly.

Now due to some problems I've faced in writing the code, each time a new user wants to enter the system, s/he needs to point to the helper contract. I think I could've figured that out had I had more time.

Other than that, the project should comply with the requirements as much as it can.

Hope you like it. Cheers.
