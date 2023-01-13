# STARPASS starter-project 🚀

---

# STARPASS スタータープロジェクト 🚀

STARPASS のスマートコントラクトに関する starter-project です。

スマートコントラクトを提出する方は, 以下の手順に従いコントラクトの実装・提出を行ってください。

1. 当レポジトリをフォークし, ローカルにクローンする。

2. 環境構築を行う。

```
$ yarn
```

2. `contracts`ディレクトリ内にコントラクトを実装する。  
   `contracts/interfaces`内に各 STARPASS プロジェクトに関するインタフェースがあります。  
   コントラクトを実装する際にはこちらのインタフェースを実装してください。  
   既に`contracts`ディレクトリ内にコントラクト例がありますので, 実装するプロジェクトを選択し中身を編集してください（コントラクト名は変更しないでください）。

3. テスト実行コマンドが実行できることを確認します。テスト内容については問いません。  
   `Social network 3.0` -> `yarn test:soc`  
   `Distributed medical database` -> `yarn test:med`  
   `Smart government` -> `yarn test:gov`

4. リモートリポジトリに反映させ, リンクを提出  
   bonus は別リポジトリで提出してください。  
   bonus に関してはインタフェース実装などの決まりはありません。必須実装される場合は別のリポジトリとして提出してください。

**提出前確認事項** 💁

-   コントラクト名が元々用意されたものであること。

-   テスト実行コマンドが実行できること。

-   bonus を実装する場合は別リポジトリにて実装・提出すること。

### 環境について 💻

このリポジトリは GitHub Actions にてリンターとフォーマッターによる解析と hardhat のテストを行っています(`.github/workflows`参照)。

-   リンター・フォーマッター  
    実行しているコマンドは`.github/workflows/analyze.yml`を, コマンドの内容は`package.json`内を参照してください。

-   hardhat テスト  
    もし`.github/workflows/hardhat.yml`内で実行しているテストの中で, あなたが削除したテストがあった場合は適宜編集してください。

**githooks を設定する** 💁

githooks ファイルが`git-hooks`ディレクトリに保存されているので, 以下コマンドで hooksPath に設定することができます。  
リモートリポジトリへのプッシュ前に自動で解析を走らせ, 修正が必要なコミットのプッシュをキャンセルすることができます。

```
$ git config core.hooksPath git-hooks/
```

**フォーマッターの設定** 💁

`.vscode/settings.json`を作成し, 以下のコードを記述するとファイル保存時に自動でフォーマッターによる整形がされます。

```json
{
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.formatOnSave": true
}
```

直接実行する場合は以下のコマンドをルートディレクトリで行います。

```
$ yarn prettier:format
```
