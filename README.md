# STARPASS starter-project 🚀

This is a starter-project for smart contracts for STARPASS.

If you wish to submit a smart contract, please follow the steps below to implement and submit the contract.

1. fork this repository and clone it locally.

2. build the environment.

```
$ yarn
```

3. implement the contracts in the `contracts` directory.  
   In `contracts/interfaces`, there are interfaces for each STARPASS project.  
   Please implement this interface when you implement a contract.  
   Since there are already example contracts in the `contracts` directory, select the project you wish to implement and edit the contents (do not change the contract name).

4. Verify that the test execution command can be executed.  
    You are free to implement the test content or not.  
   `Social network 3.0` -> `yarn test:soc`  
   `Distributed medical database` -> `yarn test:med`  
   `Smart government` -> `yarn test:gov`

5. reflect to the remote repository and submit the link.  
   There are no rules regarding interface implementation for bonus.  
   If you implement bonus, please submit it as a separate repository.

**Check list before submission** 💁

-   The contract name must be the same as the original one.

-   The test execution command must be executable.

-   If bonus is implemented, it must be implemented and submitted in a separate repository.

### About the Environment 💻

Analysis by linter/formatter and hardhat test will be executed at GitHub Actions (see `.github/workflows`).

-   Linter/Formatter  
     See `.github/workflows/analyze.yml` for the command being run, and `package.json` for the contents of the command.

-   hardhat tests  
     If there are any tests running in `.github/workflows/hardhat.yml` that you have deleted, please edit them accordingly.

**Configure githooks** 💁

Since githooks files are stored in the `git-hooks` directory, you can set the hooksPath with the following command.  
This settings run automatic parsing before pushing to the remote repository, and to cancel the push of commits that need to be fixed.

```
$ git config core.hooksPath git-hooks/
```

**Formatter Settings** 💁

Create a file `.vscode/settings.json` and write the following code to automatically format the file when it is saved.

```json
{
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.formatOnSave": true
}
```

To execute directly, execute the following command in the root directory.

```
$ yarn prettier:format
```

---

# STARPASS スタータープロジェクト 🚀

STARPASS のスマートコントラクトに関する starter-project です。

スマートコントラクトを提出する方は, 以下の手順に従いコントラクトの実装・提出を行ってください。

1. 当レポジトリをフォークし, ローカルにクローンする。

2. 環境構築を行う。

```
$ yarn
```

3. `contracts`ディレクトリ内にコントラクトを実装する。  
   `contracts/interfaces`内に各 STARPASS プロジェクトに関するインタフェースがあります。  
   コントラクトを実装する際にはこちらのインタフェースを実装してください。  
   既に`contracts`ディレクトリ内にコントラクト例がありますので, 実装するプロジェクトを選択し中身を編集してください（コントラクト名は変更しないでください）。

4. テスト実行コマンドが実行できることを確認します。テスト内容を実装するかどうかは自由です。  
   `Social network 3.0` -> `yarn test:soc`  
   `Distributed medical database` -> `yarn test:med`  
   `Smart government` -> `yarn test:gov`

5. リモートリポジトリに反映させ, リンクを提出  
   bonus に関してはインタフェース実装などの決まりはありません。bonus を実装される場合は別のリポジトリとして提出してください。

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
