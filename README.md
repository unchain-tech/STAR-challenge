# UNCHAIN STAR starter kit 🚀

This is a boilerplate for the three UNCHAIN STAR challenges.

1. fork this repository and clone it locally. `git clone git@github.com:unchain-tech/unchain-star.git`

2. install dependencies. `$ yarn`

3. implement the contracts in the `contracts/` directory. Do not modify the contract name or the interface in `contracts/interfaces`.

4. You can check if your implementation is behaving correctly using the test execution commands:
   `Social network 3.0` -> `yarn test:soc`
   `Distributed medical database` -> `yarn test:med`
   `Smart government` -> `yarn test:gov`

### About the Environment 💻

- Solhint (Solidity) and ESLint (Javascript) Linter
- Prettier formatter

**Configure githooks** 💁

You can set a git hook using the following command. The hook will be automatically ran each time before pushing to your remote repository.

```
git config core.hooksPath git-hooks/
```
