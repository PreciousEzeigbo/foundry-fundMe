# FundMe - Decentralized Crowdfunding Contract

A smart contract system built with Foundry that allows users to fund a project and enables the owner to withdraw collected funds. The contract uses Chainlink price feeds to ensure a minimum USD funding amount.

## Features

- 🔐 **Owner-only withdrawals** - Only the contract deployer can withdraw funds
- 💰 **Minimum funding threshold** - Enforces a minimum $50 USD equivalent in ETH
- 📊 **Real-time price feeds** - Uses Chainlink oracles for accurate ETH/USD conversion
- 🧪 **Comprehensive testing** - Unit and integration tests with high coverage
- 🌐 **Multi-network support** - Deployable on Sepolia testnet and local Anvil
- 📝 **Gas optimization** - Efficient withdrawal mechanism and storage patterns

## Project Structure

```
├── src/
│   ├── FundMe.sol              # Main crowdfunding
│   └── PriceConverter.sol      # Library for price conversions
├── script/
│   ├── DeployFundMe.s.sol      # Deployment script
│   ├── HelperConfig.s.sol      # Network configuration helper
│   └── Interactions.s.sol      # Fund and withdraw scripts
├── test/
│   ├── unit/
│   │   └── FundMeTest.t.sol    # Unit tests
│   ├── integration/
│   │   └── Interactions.t.sol  # Integration tests
│   └── mocks/
│       └── MockV3Aggregator.sol # Mock price feed for testing
└── Makefile                    # Build and deployment commands
```

## Prerequisites

- [Foundry](https://book.getfoundry.sh/getting-started/installation)
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

## Installation

1. Clone the repository:

```bash
git clone https://github.com/yourusername/foundry-fund-me
cd foundry-fund-me
```

2. Install dependencies:

```bash
make install
# or
forge install
```

3. Create environment file:

```bash
cp .env.example .env
```

4. Add your environment variables to `.env`:

```bash
SEPOLIA_RPC_URL=your_sepolia_rpc_url
PRIVATE_KEY=your_private_key
ETHERSCAN_API_KEY=your_etherscan_api_key
```

## Usage

### Build

```bash
make build
# or
forge build
```

### Test

```bash
# Run all tests
forge test

# Run tests with verbosity
forge test -vvv

# Run specific test file
forge test --match-path test/unit/FundMeTest.t.sol

# Run with coverage
forge coverage
```

### Deploy

#### Local Deployment (Anvil)

```bash
# Start local blockchain
anvil

# Deploy to local network
make deploy-local
```

#### Sepolia Testnet

```bash
make deploy-sepolia
```

### Interact with Contract

#### Fund the contract

```bash
# Fund with 0.1 ETH
cast send <CONTRACT_ADDRESS> "fund()" --value 0.1ether --private-key <PRIVATE_KEY> --rpc-url <RPC_URL>
```

#### Withdraw funds (owner only)

```bash
cast send <CONTRACT_ADDRESS> "Withdraw()" --private-key <PRIVATE_KEY> --rpc-url <RPC_URL>
```

#### Check contract balance

```bash
cast balance <CONTRACT_ADDRESS> --rpc-url <RPC_URL>
```

## Contract Details

### FundMe.sol

The main contract with the following key functions:

- `fund()` - Allows users to send ETH (minimum $50 USD equivalent)
- `Withdraw()` - Allows owner to withdraw all funds
- `getVersion()` - Returns Chainlink price feed version
- `getAddressToAmountFunded(address)` - Get amount funded by specific address
- `getFunder(uint256)` - Get funder address by index

### PriceConverter.sol

Library providing price conversion utilities:

- `getPrice()` - Gets current ETH/USD price from Chainlink
- `getConversionRate()` - Converts ETH amount to USD equivalent

## Testing

The project includes comprehensive tests:

### Unit Tests (`test/unit/FundMeTest.t.sol`)

- Owner verification
- Price feed functionality
- Funding requirements
- Withdrawal mechanics
- Access controls

### Integration Tests (`test/integration/Interactions.t.sol`)

- End-to-end funding and withdrawal flow
- Script interactions

### Coverage Report

```bash
forge coverage
```

## Gas Optimization

The contract implements several gas optimization techniques:

- Efficient storage patterns with `s_` prefix for storage variables
- `immutable` variables for deploy-time constants
- Batch operations in withdrawal function
- Custom errors instead of require strings

## Security Features

- **Access Control**: Only owner can withdraw funds
- **Reentrancy Protection**: Uses checks-effects-interactions pattern
- **Input Validation**: Minimum funding requirements
- **External Dependencies**: Trusted Chainlink price feeds

## Supported Networks

- **Local**: Anvil (with mock price feeds)
- **Testnet**: Sepolia
- **Mainnet**: Ethereum (configure in HelperConfig.s.sol)

## Chainlink Price Feeds

The contract uses Chainlink ETH/USD price feeds:

- **Sepolia**: `0x694AA1769357215DE4FAC081bf1f309aDC325306`
- **Mainnet**: `0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419`
- **Local**: Mock aggregator deployed automatically

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Acknowledgments

- [Foundry](https://github.com/foundry-rs/foundry) for the development framework
- [Chainlink](https://chain.link/) for reliable price feeds
- [Ctfrin Updraft](https://updraft.cyfrin.io/) for educational purposes

⚠️ **Disclaimer**: This project is for educational purposes. Always audit smart contracts before using them with real funds.
