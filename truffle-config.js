require('dotenv').config(); // Load environment variables from .env file
const HDWalletProvider = require('@truffle/hdwallet-provider');

module.exports = {
  networks: {
    sepolia: {
      provider: () =>
        new HDWalletProvider(
          process.env.PRIVATE_KEY, // Make sure this is your private key, not an address
          `https://sepolia.infura.io/v3/a6eb2b02473d490b8270bf16ab69e81e`
        ),
      network_id: 11155111, // Sepolia network ID
      confirmations: 2,     // Number of confirmations to wait between deployments
      timeoutBlocks: 200,   // Number of blocks before a deployment times out
      skipDryRun: true      // Skip dry run before migrations
    },
  },

  mocha: {
    // timeout: 100000
  },

  compilers: {
    solc: {
      version: "0.8.21",      // Exact version of Solidity to use
      settings: {
        optimizer: {
          enabled: true,
          runs: 200
        },
      }
    }
  },

  db: {
    enabled: false
  }
};
