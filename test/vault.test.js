const { expect } = require("chai");

//let Box, box, box2;

// Start test block
describe("Vault contract", function () {
  let Vault, vault, owner, addr1, addr2;

  beforeEach(async function () {
    [owner, addr1, addr2] = await ethers.getSigners();
    Vault = await ethers.getContractFactory("Vault");
    vault = await Vault.deploy();
  });
  it(" msg.sender is the owner", async function () {
    expect(await vault.owner()).to.equal(await owner.getAddress());
  });
  it("has 0 funds at the beginning", async function () {
    expect(await vault.balance()).to.equal(0);
  });
  it("is payable", async function () {
    await vault.deposit({ value: ethers.utils.parseEther("1.0") });
    expect(await vault.balance()).to.equal(ethers.utils.parseEther("1.0"));
  });
});
