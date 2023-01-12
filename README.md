# TODO

-   テストのエラーメッセージがわかりやすいようにする
-   テストのテスト関数をなるべく全部分ける
-   starter-project リポジトリ(public)と example-code/testcode(private)リポジトリに分ける

# starter-project

※ bonus 実装は別リポジトリで実装してください。

### 初期設定

```
// 依存ファイルインストール
$ yarn

// githooks ファイルが`git-hooks`ディレクトリに保存されているので, hooksPathに設定する
$ git config core.hooksPath git-hooks/
```

### 運用方法

提出者

1. 当レポジトリをフォークし, ローカルにクローンする。
2. `contracts` ディレクトリ内にコントラクトを実装する。
3. ルートにて `yarn test:soc` でテストの実行と通ることを確認する。テストファイルは通るようなサンプル入れておけばいい。
4. レポジトリを提出

以下のような example のコードを starter に入れる

```solidity
contract Sns is ISocialNetwork {
    function post(string memory _message) public returns (uint256) {
        // メッセージの投稿処理。
        // 投稿にはIDをつけてください。
        // ここでは新しく記録された投稿の ID を postId とします。

        return postId;
    }

    function like(uint256 _postId) public {
        // 投稿へのいいね処理。
    }

    function getMessage(uint256 _postId) public view returns (string memory) {
        // メッセージの取得処理。

        return message;
    }

    function getTotalLikes(uint256 _postId) public view returns (uint256) {
        // いいねの数を取得処理。

        return totalLikes;
    }

    function getTime(uint256 _postId) public view returns (uint256) {
        // 投稿日時の取得処理。

        return timestamp;
    }

    // その他の実装は自由です。
}

```
