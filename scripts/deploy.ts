import { ethers } from "hardhat"

async function main() {
  const submission = await ethers.getContractFactory("SocialNetworkExample")
  const contract = await submission.deploy()

  await contract.deployed()

  console.log(`Contract deployed to ${contract.address}`)
}

main().catch((error) => {
  console.error(error)
  process.exitCode = 1
})
