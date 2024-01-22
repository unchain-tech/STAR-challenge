// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "./interfaces/ISocialNetwork.sol";
import "hardhat/console.sol";

contract SocialNetwork is ISocialNetwork {
    string private _messageStore;
    uint256 private _id;
    uint256 private _likes;

    function post(string memory _message) external {
        console.log(_message);
    }

    function getLastPostId() external view returns (uint256) {
        return _id;
    }

    function getPost(
        uint256 _postId
    )
        external
        view
        returns (string memory message, uint256 totalLikes, uint256 time)
    {
        console.log(_postId);
        return (_messageStore, 0, 0);
    }

    function like(uint256 _postId) external {
        console.log(_postId);
        _likes++;
    }

    function unlike(uint256 _postId) external {
        console.log(_postId);
        _likes--;
    }

    // More functions
}
