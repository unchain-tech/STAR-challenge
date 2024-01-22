import { loadFixture, time } from "@nomicfoundation/hardhat-network-helpers"
import { expect } from "chai"
import { ethers } from "hardhat"

import { IGovernment } from "../typechain-types/interfaces"

describe("Government", function () {
  async function deployContract() {
    const accounts = await ethers.getSigners()

    const governmentFactory = await ethers.getContractFactory("Government")
    const government = (await governmentFactory.deploy()) as IGovernment

    return {
      government,
      deployAccount: accounts[0],
      userAccounts: accounts.slice(1, accounts.length),
    }
  }

  describe("Run for", function () {
    it("run for & check the address is registered as candidate.", async function () {
      const { government, userAccounts } = await loadFixture(deployContract)
      const candidate1 = userAccounts[0]
      await government.connect(candidate1).runForCandidate()

      expect(await government.isCandidate(candidate1.address)).to.equal(true)
    })

    it("check a address is not registered as a candidate before running for.", async function () {
      const { government, userAccounts } = await loadFixture(deployContract)
      const someone = userAccounts[0]

      expect(await government.isCandidate(someone.address)).to.equal(false)
    })
  })

  describe("Vote", function () {
    it("someone run for & check the number of vote is initially zero.", async function () {
      const { government, userAccounts } = await loadFixture(deployContract)
      const candidate1 = userAccounts[0]
      await government.connect(candidate1).runForCandidate()

      expect(await government.numberOfVotes(candidate1.address)).to.equal(0)
    })

    it("Revert transaction if there is a double vote.", async function () {
      const { government, userAccounts } = await loadFixture(deployContract)

      const candidate1 = userAccounts[0]
      const voter1 = userAccounts[1]

      await government.connect(candidate1).runForCandidate()

      // first time
      await government.connect(voter1).vote(candidate1.address)
      // second time -> revert
      await expect(government.connect(voter1).vote(candidate1.address)).to.be
        .reverted
    })

    it("Revert transaction if there is a vote after abstain.", async function () {
      const { government, userAccounts } = await loadFixture(deployContract)

      const candidate1 = userAccounts[0]
      const voter1 = userAccounts[1]

      await government.connect(candidate1).runForCandidate()

      // abstain.
      await government.connect(voter1).abstain()
      // vote -> revert
      await expect(government.connect(voter1).vote(candidate1.address)).to.be
        .reverted
    })
  })

  describe("Determine winner", function () {
    it("Candidates run for & voters vote & determine president & check president.", async function () {
      const { government, userAccounts } = await loadFixture(deployContract)

      const threeWeeksInSeconds = 60 * 60 * 24 * 7 * 3
      const numOfCandidates = 3
      const indexOfPresident = 1
      const candidates = userAccounts.slice(0, numOfCandidates)
      const voters = userAccounts.slice(numOfCandidates, userAccounts.length)

      // Run for.
      for (let index = 0; index < candidates.length; index++) {
        await government.connect(candidates[index]).runForCandidate()
      }

      // Vote.
      for (let voterIndex = 0; voterIndex < voters.length; voterIndex++) {
        let candidateIndexToVote: number = voterIndex % numOfCandidates
        if (candidateIndexToVote === 0 || candidateIndexToVote === 1) {
          candidateIndexToVote = indexOfPresident
        }
        await government
          .connect(voters[voterIndex])
          .vote(candidates[candidateIndexToVote].address)
      }

      // Adjust the end time.
      await time.increase(threeWeeksInSeconds)

      // Determine president.
      await government.determinePresident()

      expect(await government.getPresident()).to.equal(
        candidates[indexOfPresident].address,
      )
    })
  })
})
