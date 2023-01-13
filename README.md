---

# starter-project 🚀

STARPASS 提出方法

1. STARPASS-starter-project をフォークする
2. インタフェースを実装
3. テストが通ることを確認します
4. 提出

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
