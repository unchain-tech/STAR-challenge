import { loadFixture } from "@nomicfoundation/hardhat-network-helpers"
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

    describe("", function () {
        it("", async function () {
            await loadFixture(deployContract)
        })
    })
})
