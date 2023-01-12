// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "./interfaces/ISocialNetwork.sol";

contract SocialNetwork is ISocialNetwork {
    string private _messageStore;
    uint256 private _id;
    uint256 private _likes;

    function post(string memory _message) external{
        _messageStore = _message;
    }

    function getLastPostId() external view returns (uint256){
        return _id;
    }

    function getPost(uint256 _postId)
        external
        view
        returns (
            string memory message,
            uint256 totalLikes,
            uint256 time
        ){
            delete _postId;
            return (_messageStore, 0, 0);
        }

    function like(uint256 _postId) external{
        delete _postId;
        _likes++;
    }

    function unlike(uint256 _postId) external{
        delete _postId;
        _likes--;
    }

    // More functions
}
