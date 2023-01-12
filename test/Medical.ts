import { loadFixture } from "@nomicfoundation/hardhat-network-helpers"
import { ethers } from "hardhat"

import { IMedical } from "../typechain-types/interfaces"

describe("Medical", function () {
    async function deploy() {
        const accounts = await ethers.getSigners()
        const deployAccount = accounts[0]
        const userAccounts = accounts.slice(1, accounts.length)

        // Deploy.
        const medicalFactory = await ethers.getContractFactory("Medical")
        const medical = (await medicalFactory.deploy()) as IMedical

        return {
            medical,
            deployAccount,
            userAccounts,
        }
    }

    describe("", function () {
        it("", async function () {
            const {} = await loadFixture(deploy)
        })
    })
})
