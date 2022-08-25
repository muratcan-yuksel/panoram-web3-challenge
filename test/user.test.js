const { expect } = require("chai");

// Start test block
describe("User contract", function () {
  let User, user, owner, addr1, addr2, value, proxyAddress, Helper, helper;

  this.beforeEach(async function () {
    [owner, addr1, addr2] = await ethers.getSigners();
    User = await ethers.getContractFactory("User");
    user = await User.deploy();

    //deploy helper contract
    Helper = await ethers.getContractFactory("Helper");
    helper = await Helper.deploy();
  });

  //   beforeEach(async function () {
  //     [owner, addr1, addr2] = await ethers.getSigners();
  //     Vault = await ethers.getContractFactory("Vault");
  //     vault = await Vault.deploy();
  //   });
  //   it(" msg.sender is the owner", async function () {
  //     expect(await vault.owner()).to.equal(await owner.getAddress());
  //   });
  //   it("has 0 funds at the beginning", async function () {
  //     expect(await vault.balance()).to.equal(0);
  //   });
  //   it("is payable", async function () {
  //     await vault.deposit({ value: ethers.utils.parseEther("1.0") });
  //     expect(await vault.balance()).to.equal(ethers.utils.parseEther("1.0"));
  //   });
});
