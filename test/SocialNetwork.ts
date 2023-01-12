import { loadFixture } from "@nomicfoundation/hardhat-network-helpers"
import { ethers } from "hardhat"

import { ISocialNetwork } from "../typechain-types/interfaces"

describe("SocialNetwork", function () {
    async function deployContract() {
        const accounts = await ethers.getSigners()

        const snsFactory = await ethers.getContractFactory("SocialNetwork")
        const socialNetwork = (await snsFactory.deploy()) as ISocialNetwork

        return {
            socialNetwork,
            deployAccount: accounts[0],
            userAccounts: accounts.slice(1, accounts.length),
        }
    }

    describe("", function () {
        it("", async function () {
            const {} = await loadFixture(deployContract)
        })
    })
})
