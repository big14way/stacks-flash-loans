# Stacks Flash Loans - Clarity 4 Enhanced ⚡

Code for the [LearnWeb3](https://learnweb3.io) course about building a Flash Loans protocol. Part of the [Stacks Developer Degree](https://learnweb3.io/degrees/stacks-developer-degree).

**Upgraded to Clarity 4 (Epoch 3.3)** with enhanced security features and new built-in functions!

## ✨ New Clarity 4 Features Used

This project leverages the following **NEW Clarity 4 functions**:

1. **`contract-hash?`** - Get contract hash for integrity verification
   - Function: `get-contract-hash()` - Returns the contract's hash
   - Function: `verify-contract-integrity()` - Verifies contract integrity
   - Available in `flasher-v4`, `mock-token-v4`, and `mock-flash-recipient-v4` contracts

2. **`to-ascii?`** - Convert uint to ASCII string representation
   - Function: `interest-to-string(interest)` - Converts interest amount to ASCII
   - Function: `amount-to-string(amount)` - Converts token amount to ASCII

3. **`stacks-block-height`** - Access current block height for time-based logic
   - Function: `get-current-block-height()` - Get current block height
   - Enables future time-based flash loan tracking

4. **`as-contract?`** - Enhanced security for contract calls (Clarity 4)
   - Used in `flash-stx` with `with-stx` for STX flash loans
   - Used in `flash-sip010` with `with-all-assets-unsafe` for fungible token flash loans
   - Secure token transfer with allowance control for repayments
   - **Note**: `as-contract?` is fully implemented for production deployment but test SDK support is pending

5. **Enhanced Flash Loan Security** - New Clarity 4 features enable:
   - Precise asset allowance control during flash loan execution
   - Better security with explicit permission scoping
   - Improved auditability of flash loan operations

## Live Demo

**[View Live Application](https://frontend-daxhsd6le-big14ways-projects.vercel.app)** 🚀

## WalletConnect Integration

This project now includes a modern Next.js frontend with **WalletConnect v2** integration, enabling secure wallet connections for flash loan operations.

### Features

- Full WalletConnect v2 support for Stacks blockchain
- Support for flash loan operations through wallet:
  - Message signing
  - STX transfers
  - Contract calls for flash loans
  - Contract deployment
- Modern, responsive UI built with Next.js 15 and Tailwind CSS
- TypeScript for type safety
- Dark mode support

### Getting Started

#### Prerequisites

- Node.js 18+ installed
- A WalletConnect Project ID (already configured)

#### Installation

```bash
cd frontend
npm install
```

#### Development

```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) to view the application.

#### Environment Variables

The frontend uses the following environment variable:

```
NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID=1eebe528ca0ce94a99ceaa2e915058d7
```

This is already configured in `.env.local`.

#### Building for Production

```bash
npm run build
npm start
```

### Architecture

- `/lib/walletconnect.ts` - Core WalletConnect client implementation
- `/components/WalletProvider.tsx` - React context provider for wallet state management
- `/components/WalletConnectButton.tsx` - Wallet connection UI component
- `/app/page.tsx` - Main application page
- `/app/layout.tsx` - Root layout with WalletProvider

### Deployment

This project is ready to be deployed to Vercel:

```bash
vercel deploy
```

Make sure to set the `NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID` environment variable in your Vercel project settings.

## 🧪 Testing

This project includes comprehensive tests for Clarity 4 functionality.

**Note**: The `as-contract?` function is fully implemented in the contracts for production deployment (Epoch 3.3), but the current test SDK doesn't yet support this Clarity 4 feature. The contracts pass `clarinet check` validation and are ready for testnet/mainnet deployment.

### Contract Validation

```bash
# Verify contracts pass Clarity 4 validation
clarinet check
```

**Result**: ✅ All 5 contracts checked and validated for Clarity 4 (Epoch 3.3)

## 🚀 Deployment

**Status: DEPLOYED TO TESTNET** ✅

### Deployed Contracts

The contracts have been successfully deployed to Stacks testnet:

- **Deployer Address**: `ST1NA1KECSN6QSZQM652X5AEDKBR6RMEJ0JGCX99Q`
- **Flash Loans Trait (v4)**: `ST1NA1KECSN6QSZQM652X5AEDKBR6RMEJ0JGCX99Q.flashloans-trait-v4`
- **Flasher (v4)**: `ST1NA1KECSN6QSZQM652X5AEDKBR6RMEJ0JGCX99Q.flasher-v4`
- **Mock Flash Recipient (v4)**: `ST1NA1KECSN6QSZQM652X5AEDKBR6RMEJ0JGCX99Q.mock-flash-recipient-v4`
- **Mock Token (v4)**: `ST1NA1KECSN6QSZQM652X5AEDKBR6RMEJ0JGCX99Q.mock-token-v4` (shared with multisig)

**Transaction IDs:**
- Flash Loans Trait: `a0eda27575795d45618404ff52bfa55240b5e156bd3b0328a54b5ef9d2ac2fb0`
- Flasher: `e800f29d0b54d743911065cd6d940d1490fa114c2c35d0e6f27c6dddcc8982f9`
- Mock Flash Recipient: `2cfb64dfab2e97801cee1ac7490af886bd0436f026dca0a7218c6ad59b236e30`

### Deployment Details

```bash
# Deploy to testnet (using --no-dashboard flag for non-interactive environments)
clarinet deployments apply --testnet --no-dashboard -c
```

**Deployment Configuration:**
- Contract Names: `flasher-v4`, `flashloans-trait-v4`, `mock-flash-recipient-v4`, `mock-token-v4`
- Clarity Version: 4
- Epoch: 3.3
- Network: Stacks Testnet
- Total Cost: 0.124670 STX
- Duration: 2 blocks

The contracts passed all Clarity 4 validation checks and are now live on testnet.

## 📋 Clarity 4 Contract Details

### Contracts

1. **flasher-v4** - Main flash loan protocol contract with Clarity 4 features
   - STX flash loans with `with-stx` allowances
   - SIP-010 token flash loans with `with-all-assets-unsafe` allowances
   - Interest calculation (0.5% for STX, 1% for SIP-010)
   - Contract integrity verification

2. **flashloans-trait-v4** - Trait definitions for flash loan receivers
   - `stx-flasher` trait for STX flash loan callbacks
   - `sip010-flasher` trait for SIP-010 token flash loan callbacks

3. **mock-flash-recipient-v4** - Example flash loan receiver implementation
   - Demonstrates how to implement flash loan callbacks
   - Clarity 4 secure repayment with `as-contract?`
   - Contract hash verification

4. **mock-token-v4** - SIP-010 fungible token for testing
   - Clarity 4 helper functions
   - Amount-to-string conversion
   - Shared with multisig project

### Key Improvements in Clarity 4

- **Better Security**: Enhanced with `as-contract?` for precise asset control during flash loans
- **More Transparency**: Contract hash verification for integrity checks
- **Improved Auditability**: Block-height tracking for future time-based features
- **Future-Ready**: Foundation for time-locked flash loans and advanced DeFi features
