// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";
import "./interfaces/ISocialNetwork.sol";

contract SocialNetwork is ISocialNetwork {
    // postオブジェクト定義
    struct Post {
        uint256 id;
        uint256 timestamp;
        uint256 totalLikes;
        string message;
        address user;
        address[] likes;
    }

    // postの配列
    Post[] public posts;

    // postのIdに使うカウンター定義
    using Counters for Counters.Counter;
    Counters.Counter private _postIds;

    // グローバルタイムラインへのpostの追加
    function post(string memory _message) public {
        Post memory newPost;
        newPost.id = _postIds.current();
        newPost.user = msg.sender;
        newPost.message = _message;
        newPost.timestamp = uint256(block.timestamp);

        posts.push(newPost);

        _postIds.increment();
    }

    // likeの追加/削除
    function like(uint256 _postId) public {
        // 削除した場合のフラグ
        bool _deleted;

        // like対象のpost構造体を抽出
        for (uint256 i = 0; i < posts.length; i++) {
            // 対象のpostでない場合は次へ
            if (posts[i].id != _postId) {
                continue;
            }

            // like配列に対象のアドレスが含まれるか判定し、含まれる場合は削除する
            address[] storage likes = posts[i].likes;
            for (uint256 j = 0; j < likes.length; j++) {
                // 対象でない場合は次へ
                if (likes[j] != msg.sender) {
                    continue;
                }
                // deleteでは要素の値が0になるだけで削除されない
                // delete posts[i].likes[j];
                // 削除したい要素が2の場合以下のようになる
                // ex [1,2,3,4] -> [1,0,3,4]

                // 削除したい要素に最後の要素を設定し、最後の要素をpopすることで削除する
                // ex [1,2,3,4]の2を削除
                // [1,2,3,4] -> [1,4,3,4] -> [1,4,3]
                // ただし、要素のindexが変わってしまう
                likes[j] = likes[likes.length - 1];
                likes.pop();
                posts[i].totalLikes--;
                _deleted = true;
                break;
            }
            // like配列にアドレスが含まれていない場合はアドレスを追加する
            if (!_deleted) {
                posts[i].likes.push(msg.sender);
                posts[i].totalLikes++;
                break;
            }
        }
    }

    function unlike(uint256 _postId) public {
        like(_postId);
    }

    function getLastPostId() public view returns (uint256) {
        return posts[posts.length - 1].id;
    }

    function getPost(
        uint256 _postId
    )
        external
        view
        returns (string memory message, uint256 totalLikes, uint256 time)
    {
        for (uint256 i = 0; i < posts.length; i++) {
            if (posts[i].id == _postId) {
                return (
                    posts[i].message,
                    posts[i].totalLikes,
                    posts[i].timestamp
                );
            }
        }
        Post memory emptyPost;
        return (emptyPost.message, emptyPost.totalLikes, emptyPost.timestamp);
    }

    // 全てのpostを取得
    function getAllPosts() public view returns (Post[] memory) {
        return posts;
    }
}
