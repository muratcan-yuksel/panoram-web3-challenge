## on testing

example testing:

```javsacript
const {expect} require("chai");

describe("Token contract"), ()=>{
    let Token, token, owner, addr, addr2;
    beforeEach(async()=>{
        Token= await ethers.getContractFactory("Token");
        token= await Token.deploy();
        [owner, addr1, addr2, _]= await ethers.getSigners();
    })
}
```
