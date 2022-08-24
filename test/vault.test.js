const { expect } = require("chai");

//let Box, box, box2;

// Start test block
describe("Vault contract", function () {
  let Vault, vault, owner, addr1, addr2;

  beforeEach(async function () {
    Vault = await ethers.getContractFactory("Vault");
    vault = await Vault.deploy();
    [owner, addr1, addr2] = await ethers.getSigners();
  });
  it(" msg.sender is the owner", async function () {
    expect(await vault.owner()).to.equal(await owner.getAddress());

    // Transfer 50 tokens from owner to addr1
    // await hardhatToken.transfer(addr1.address, 50);
    // expect(await hardhatToken.balanceOf(addr1.address)).to.equal(50);
  });
});
