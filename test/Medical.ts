import { loadFixture } from "@nomicfoundation/hardhat-network-helpers"
import { expect } from "chai"
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

  async function deployAndRegister() {
    const { medical, deployAccount, userAccounts } = await loadFixture(deploy)

    const patient = userAccounts[0]
    const otherAccounts = userAccounts.slice(1, userAccounts.length)

    const defaultName = "Default patient"
    const defaultBloodType = "A"
    await medical.connect(patient).register(defaultName, defaultBloodType)
    return {
      medical,
      deployAccount,
      patient,
      otherAccounts,
      defaultName,
      defaultBloodType,
    }
  }

  describe("Register and get data.", function () {
    it("Verify that the correct name is registered.", async function () {
      const { medical, patient, defaultName } = await deployAndRegister()

      const { name } = await medical
        .connect(patient)
        .getMedicalData(patient.address)

      expect(name).to.equal(defaultName)
    })

    it("Verify that the correct blood type is registered.", async function () {
      const { medical, patient, defaultBloodType } = await deployAndRegister()

      const { bloodType } = await medical
        .connect(patient)
        .getMedicalData(patient.address)

      expect(bloodType).to.equal(defaultBloodType)
    })

    // Skip the test of time of last update because it's implementation-dependent.
  })

  describe("Edit medical data", function () {
    it("Patients can update their name.", async function () {
      const { medical, patient } = await deployAndRegister()

      const newName = "new name"
      await medical.connect(patient).updateName(newName)

      const { name } = await medical
        .connect(patient)
        .getMedicalData(patient.address)

      expect(name).to.equal(newName)
    })

    it("Patients can update their blood type.", async function () {
      const { medical, patient } = await deployAndRegister()

      const newBloodType = "B"
      await medical.connect(patient).updateBloodType(newBloodType)

      const { bloodType } = await medical
        .connect(patient)
        .getMedicalData(patient.address)

      expect(bloodType).to.equal(newBloodType)
    })
  })

  describe("Viewing access", function () {
    it("No viewing access by default.", async function () {
      const { medical, patient, otherAccounts } = await deployAndRegister()

      const medicalProvider = otherAccounts[0]

      expect(
        await medical.isViewingAccessGranted(
          patient.address,
          medicalProvider.address,
        ),
      ).to.equal(false)
    })

    it("Check viewing access after provided.", async function () {
      const { medical, patient, otherAccounts } = await deployAndRegister()

      const medicalProvider = otherAccounts[0]
      await medical
        .connect(patient)
        .provideViewingAccess(medicalProvider.address)

      expect(
        await medical.isViewingAccessGranted(
          patient.address,
          medicalProvider.address,
        ),
      ).to.equal(true)
    })
  })
})
