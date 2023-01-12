// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "./interfaces/ISocialNetwork.sol";

contract SocialNetwork is ISocialNetwork {
    string public message;
    

    function post(string memory _message) external {
        message = _message;
    }

    function getLastPostId() external view returns (uint256) {
        return 0;
    }

    function getPost(uint256 _postId)
        external
        view
        returns (
            string memory message,
            uint256 totalLikes,
            uint256 time
        ) {
            return (message, 0, 0);
        }

    function like(uint256 _postId) external {

    }

    function unlike(uint256 _postId) external {

    }
}
