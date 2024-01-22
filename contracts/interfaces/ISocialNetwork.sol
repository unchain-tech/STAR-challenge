// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

interface ISocialNetwork {
    // Post a message.
    // This posted data must be accessible by the post's id from the getter function that follows below.
    function post(string memory _message) external;

    // Returns id of the last post.
    function getLastPostId() external view returns (uint256);

    // Returns the data of the post by its id.
    function getPost(uint256 _postId)
        external
        view
        returns (
            string memory message,
            uint256 totalLikes,
            uint256 time
        );

    // Like a post by its id.
    function like(uint256 _postId) external;

    // Unlike a post by its id.
    function unlike(uint256 _postId) external;
}
