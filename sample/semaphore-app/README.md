# Semaphore Hardhat + Next.js + SemaphoreEthers template

This project is a complete application that demonstrates a basic Semaphore use case. It comes with a sample contract, a test for that contract and a sample task that deploys that contract. It also contains a frontend to play around with the contract.

## Install

### Install dependencies

```bash
yarn
```

## 📜 Usage

### Local server

You can start your app locally with:

```bash
yarn dev
```

ローカルで動かした時の記録

```bash
[monorepo-ethers-web-app]: > [PWA] PWA support is disabled
[monorepo-ethers-web-app]: > [PWA] PWA support is disabled
[monorepo-ethers-contracts]: Successfully generated 34 typings!
[monorepo-ethers-contracts]: Compiled 15 Solidity files successfully (evm target: paris).
[monorepo-ethers-contracts]: WARNING: You are currently using Node.js v23.3.0, which is not supported by Hardhat. This can lead to unexpected behavior. See https://hardhat.org/nodejs-versions
[monorepo-ethers-contracts]:
[monorepo-ethers-contracts]:
[monorepo-ethers-web-app]:  ✓ Ready in 2.7s
[monorepo-ethers-contracts]: eth_accounts
[monorepo-ethers-contracts]: hardhat_metadata
[monorepo-ethers-contracts]: hardhat_metadata (2)
[monorepo-ethers-contracts]: hardhat_metadata (3)
[monorepo-ethers-contracts]: hardhat_metadata (4)
[monorepo-ethers-contracts]: hardhat_metadata (5)
[monorepo-ethers-contracts]: hardhat_metadata (6)
[monorepo-ethers-contracts]: hardhat_metadata (7)
[monorepo-ethers-contracts]: hardhat_metadata (8)
[monorepo-ethers-contracts]: hardhat_metadata (9)
[monorepo-ethers-contracts]: hardhat_metadata (10)
[monorepo-ethers-contracts]: hardhat_metadata (11)
[monorepo-ethers-contracts]: hardhat_metadata (12)
[monorepo-ethers-contracts]: hardhat_metadata (13)
[monorepo-ethers-contracts]: hardhat_metadata (14)
[monorepo-ethers-contracts]: hardhat_metadata (15)
[monorepo-ethers-contracts]: hardhat_metadata (16)
[monorepo-ethers-contracts]: hardhat_metadata (17)
[monorepo-ethers-contracts]: hardhat_metadata (18)
[monorepo-ethers-contracts]: hardhat_metadata (19)
[monorepo-ethers-contracts]: hardhat_metadata (20)
[monorepo-ethers-contracts]: eth_blockNumber
[monorepo-ethers-contracts]: eth_getBlockByNumber
[monorepo-ethers-contracts]: eth_feeHistory
[monorepo-ethers-contracts]: eth_maxPriorityFeePerGas
[monorepo-ethers-contracts]: eth_sendTransaction
[monorepo-ethers-contracts]:   Contract deployment: <UnrecognizedContract>
[monorepo-ethers-contracts]:   Contract address:    0x5fbdb2315678afecb367f032d93f642f64180aa3
[monorepo-ethers-contracts]:   Transaction:         0xd8d40186c357a3f4688360a68cf51850eb7462f3bc2232e998f9725c115d2120
[monorepo-ethers-contracts]:   From:                0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266
[monorepo-ethers-contracts]:   Value:               0 ETH
[monorepo-ethers-contracts]:   Gas used:            3803921 of 30000000
[monorepo-ethers-contracts]:   Block #1:            0x4773f9c1826ffe8e41b985a15c51ae2da38af02d7f6c566f2568eaca1f2c91f6
[monorepo-ethers-contracts]:
[monorepo-ethers-contracts]: eth_getTransactionByHash
[monorepo-ethers-contracts]: SemaphoreVerifier contract has been deployed to: 0x5FbDB2315678afecb367f032d93F642f64180aa3
[monorepo-ethers-contracts]: eth_accounts
[monorepo-ethers-contracts]: hardhat_metadata
[monorepo-ethers-contracts]: hardhat_metadata (2)
[monorepo-ethers-contracts]: hardhat_metadata (3)
[monorepo-ethers-contracts]: hardhat_metadata (4)
[monorepo-ethers-contracts]: hardhat_metadata (5)
[monorepo-ethers-contracts]: hardhat_metadata (6)
[monorepo-ethers-contracts]: hardhat_metadata (7)
[monorepo-ethers-contracts]: hardhat_metadata (8)
[monorepo-ethers-contracts]: hardhat_metadata (9)
[monorepo-ethers-contracts]: hardhat_metadata (10)
[monorepo-ethers-contracts]: hardhat_metadata (11)
[monorepo-ethers-contracts]: hardhat_metadata (12)
[monorepo-ethers-contracts]: hardhat_metadata (13)
[monorepo-ethers-contracts]: hardhat_metadata (14)
[monorepo-ethers-contracts]: hardhat_metadata (15)
[monorepo-ethers-contracts]: hardhat_metadata (16)
[monorepo-ethers-contracts]: hardhat_metadata (17)
[monorepo-ethers-contracts]: hardhat_metadata (18)
[monorepo-ethers-contracts]: hardhat_metadata (19)
[monorepo-ethers-contracts]: hardhat_metadata (20)
[monorepo-ethers-contracts]: eth_blockNumber
[monorepo-ethers-contracts]: eth_feeHistory
[monorepo-ethers-contracts]: eth_sendTransaction
[monorepo-ethers-contracts]:   Contract deployment: <UnrecognizedContract>
[monorepo-ethers-contracts]:   Contract address:    0xe7f1725e7734ce288f8367e1bb143e90bb3f0512
[monorepo-ethers-contracts]:   Transaction:         0xfcc18e533a72bb558afa39e73a493beb5989d9de02da6a84b5ffdcd4d573807c
[monorepo-ethers-contracts]:   From:                0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266
[monorepo-ethers-contracts]:   Value:               0 ETH
[monorepo-ethers-contracts]:   Gas used:            5245581 of 30000000
[monorepo-ethers-contracts]:   Block #2:            0x73aa783598a75521687ca7d43984da0926a27c9e68a6cbadac14e11f239f359e
[monorepo-ethers-contracts]:
[monorepo-ethers-contracts]: eth_getTransactionByHash
[monorepo-ethers-contracts]: Poseidon library has been deployed to: 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512
[monorepo-ethers-contracts]: eth_accounts
[monorepo-ethers-contracts]: hardhat_metadata
[monorepo-ethers-contracts]: hardhat_metadata (2)
[monorepo-ethers-contracts]: hardhat_metadata (3)
[monorepo-ethers-contracts]: hardhat_metadata (4)
[monorepo-ethers-contracts]: hardhat_metadata (5)
[monorepo-ethers-contracts]: hardhat_metadata (6)
[monorepo-ethers-contracts]: hardhat_metadata (7)
[monorepo-ethers-contracts]: hardhat_metadata (8)
[monorepo-ethers-contracts]: hardhat_metadata (9)
[monorepo-ethers-contracts]: hardhat_metadata (10)
[monorepo-ethers-contracts]: hardhat_metadata (11)
[monorepo-ethers-contracts]: hardhat_metadata (12)
[monorepo-ethers-contracts]: hardhat_metadata (13)
[monorepo-ethers-contracts]: hardhat_metadata (14)
[monorepo-ethers-contracts]: hardhat_metadata (15)
[monorepo-ethers-contracts]: hardhat_metadata (16)
[monorepo-ethers-contracts]: hardhat_metadata (17)
[monorepo-ethers-contracts]: hardhat_metadata (18)
[monorepo-ethers-contracts]: hardhat_metadata (19)
[monorepo-ethers-contracts]: hardhat_metadata (20)
[monorepo-ethers-contracts]: eth_blockNumber
[monorepo-ethers-contracts]: eth_feeHistory
[monorepo-ethers-contracts]: eth_sendTransaction
[monorepo-ethers-contracts]:   Contract deployment: <UnrecognizedContract>
[monorepo-ethers-contracts]:   Contract address:    0x9fe46736679d2d9a65f0992f2272de9f3c7fa6e0
[monorepo-ethers-contracts]:   Transaction:         0x50ad7d4de5adc34ac2cfdcf5ec5d1304d6b9f6d2660525370741c8b0a2fd6a66
[monorepo-ethers-contracts]:   From:                0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266
[monorepo-ethers-contracts]:   Value:               0 ETH
[monorepo-ethers-contracts]:   Gas used:            2928901 of 30000000
[monorepo-ethers-contracts]:   Block #3:            0x008d80be4a7eeb9dad6844feb7af1832342ab3b80b038c237ca2cae2b269b034
[monorepo-ethers-contracts]:
[monorepo-ethers-contracts]: eth_getTransactionByHash
[monorepo-ethers-contracts]: Semaphore contract has been deployed to: 0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0
[monorepo-ethers-contracts]: eth_accounts
[monorepo-ethers-contracts]: hardhat_metadata
[monorepo-ethers-contracts]: hardhat_metadata (2)
[monorepo-ethers-contracts]: hardhat_metadata (3)
[monorepo-ethers-contracts]: hardhat_metadata (4)
[monorepo-ethers-contracts]: hardhat_metadata (5)
[monorepo-ethers-contracts]: hardhat_metadata (6)
[monorepo-ethers-contracts]: hardhat_metadata (7)
[monorepo-ethers-contracts]: hardhat_metadata (8)
[monorepo-ethers-contracts]: hardhat_metadata (9)
[monorepo-ethers-contracts]: hardhat_metadata (10)
[monorepo-ethers-contracts]: hardhat_metadata (11)
[monorepo-ethers-contracts]: hardhat_metadata (12)
[monorepo-ethers-contracts]: hardhat_metadata (13)
[monorepo-ethers-contracts]: hardhat_metadata (14)
[monorepo-ethers-contracts]: hardhat_metadata (15)
[monorepo-ethers-contracts]: hardhat_metadata (16)
[monorepo-ethers-contracts]: hardhat_metadata (17)
[monorepo-ethers-contracts]: hardhat_metadata (18)
[monorepo-ethers-contracts]: hardhat_metadata (19)
[monorepo-ethers-contracts]: hardhat_metadata (20)
[monorepo-ethers-contracts]: eth_blockNumber
[monorepo-ethers-contracts]: eth_feeHistory
[monorepo-ethers-contracts]: eth_sendTransaction
[monorepo-ethers-contracts]:   Contract deployment: <UnrecognizedContract>
[monorepo-ethers-contracts]:   Contract address:    0xcf7ed3acca5a467e9e704c703e8d87f634fb0fc9
[monorepo-ethers-contracts]:   Transaction:         0xf797eaa99c3e887496edd66f16983da57cc817e9ddee291fe498e51a2c9385b9
[monorepo-ethers-contracts]:   From:                0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266
[monorepo-ethers-contracts]:   Value:               0 ETH
[monorepo-ethers-contracts]:   Gas used:            491213 of 30000000
[monorepo-ethers-contracts]:   Block #4:            0x667747425aa11bda7695fd21189bf9d02b2877a6df936d23810caa31f8d01cf0
[monorepo-ethers-contracts]:
[monorepo-ethers-contracts]: eth_getTransactionByHash
[monorepo-ethers-contracts]: Feedback contract has been deployed to: 0xCf7Ed3AccA5a467e9e704C703E8D87F634fB0Fc9
```

### Deploy the contract

1. Go to the `apps/contracts` directory and deploy your contract:

```bash
yarn deploy --semaphore <semaphore-address> --network sepolia
```

sepoliaへのデプロイは以下のコマンドで実行する

```bash
yarn deploy --semaphore 0x8A1fd199516489B0Fb7153EB5f075cDAC83c693D --network sepolia
```

2. Update your `apps/web-app/.env.production` file with your new contract address and the group id.

3. Copy your contract artifacts from `apps/contracts/artifacts/contracts/` folder to `apps/web-app/contract-artifacts` folder manually.

> [!NOTE]
> Check the Semaphore contract addresses [here](https://docs.semaphore.pse.dev/deployed-contracts).

### Code quality and formatting

Run [ESLint](https://eslint.org/) and [solhint](https://github.com/protofire/solhint) to analyze the code and catch bugs:

```bash
yarn lint
```

Run [Prettier](https://prettier.io/) to check formatting rules:

```bash
yarn prettier
```

Or to automatically format the code:

```bash
yarn prettier:write
```
