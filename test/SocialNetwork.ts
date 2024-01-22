import { loadFixture } from "@nomicfoundation/hardhat-network-helpers"
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers"
import { expect } from "chai"
import { BigNumber } from "ethers"
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

  async function postAndGetId(
    socialNetwork: ISocialNetwork,
    signer: SignerWithAddress,
    msg: string,
  ) {
    await socialNetwork.connect(signer).post(msg)
    return await socialNetwork.getLastPostId()
  }

  describe("Post and get post", function () {
    async function deployAndPost() {
      const { socialNetwork, deployAccount } = await loadFixture(deployContract)
      const msg = "first post"
      const id = await postAndGetId(socialNetwork, deployAccount, msg)
      return { socialNetwork, id, msg }
    }

    it("Post and verify that the correct message is posted.", async function () {
      const { socialNetwork, id, msg } = await deployAndPost()

      const { message } = await socialNetwork.getPost(id)
      expect(message).to.equal(msg)
    })

    it("Post and verify that the correct number of likes is posted.", async function () {
      const { socialNetwork, id } = await deployAndPost()

      const { totalLikes } = await socialNetwork.getPost(id)
      expect(totalLikes).to.equal(0)
    })

    // Skip the test of time of post because it's implementation-dependent.

    it("Post multiple and verify that the correct messages is posted.", async function () {
      const { socialNetwork, userAccounts } = await loadFixture(deployContract)

      type PostType = {
        id: BigNumber
        msg: string
      }

      const allPosts: PostType[] = []

      // Multiple post and store the data in allPosts.
      for (let i = 0; i < userAccounts.length; i++) {
        const newMsg = userAccounts[i].address
        const newId = await postAndGetId(socialNetwork, userAccounts[i], newMsg)
        const newPost: PostType = {
          id: newId,
          msg: newMsg,
        }
        allPosts.push(newPost)
      }

      for (const post of allPosts) {
        const { message } = await socialNetwork.getPost(post.id)
        expect(message).to.equal(post.msg)
      }
    })
  })

  describe("Like", function () {
    it("The total number of likes is increase if one account like.", async function () {
      const { socialNetwork, userAccounts } = await loadFixture(deployContract)

      const accountToPost = userAccounts[0]
      const accountToLike = userAccounts[1]

      const id = await postAndGetId(socialNetwork, accountToPost, "message")
      const { totalLikes: totalLikesBefore } = await socialNetwork.getPost(id)

      await socialNetwork.connect(accountToLike).like(id)

      const { totalLikes: totalLikesAfter } = await socialNetwork.getPost(id)
      expect(totalLikesAfter.sub(totalLikesBefore)).to.equal(1)
    })

    it("The total number of likes is increase if multiple accounts like.", async function () {
      const { socialNetwork, userAccounts } = await loadFixture(deployContract)

      const accountToPost = userAccounts[0]
      const otherAccounts = userAccounts.slice(1, userAccounts.length)

      const id = await postAndGetId(socialNetwork, accountToPost, "message")
      const { totalLikes: totalLikesBefore } = await socialNetwork.getPost(id)

      for (let i = 0; i < otherAccounts.length; i++) {
        await socialNetwork.connect(otherAccounts[i]).like(id)
      }

      const { totalLikes: totalLikesAfter } = await socialNetwork.getPost(id)
      expect(totalLikesAfter.sub(totalLikesBefore)).to.equal(
        otherAccounts.length,
      )
    })
  })

  describe("unlike", function () {
    it("The total number of likes is decrease if one account unlike.", async function () {
      const { socialNetwork, userAccounts } = await loadFixture(deployContract)

      const accountToPost = userAccounts[0]
      const accountToUnlike = userAccounts[1]

      const id = await postAndGetId(socialNetwork, accountToPost, "message")
      const { totalLikes: totalLikesBefore } = await socialNetwork.getPost(id)

      await socialNetwork.connect(accountToUnlike).like(id)

      const { totalLikes: totalLikesAfterLike } = await socialNetwork.getPost(
        id,
      )
      expect(totalLikesAfterLike.sub(totalLikesBefore)).to.equal(1)

      await socialNetwork.connect(accountToUnlike).unlike(id)

      const { totalLikes: totalLikesAfterUnlike } = await socialNetwork.getPost(
        id,
      )
      expect(totalLikesAfterUnlike.sub(totalLikesBefore)).to.equal(0)
    })
  })
})
