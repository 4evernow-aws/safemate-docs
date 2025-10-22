## Hedera Account Creation Without an Operator (Testnet → Mainnet)

This guide shows how to create Hedera accounts without running an operator/treasury account. Accounts are auto-created the first time they receive HBAR sent to an alias derived from the user's key. Use this with fiat on-ramps (e.g., Banxa, Alchemy Pay) or direct crypto funding.

### Key Idea: Auto Account Creation via Alias
- **No operator needed**: If HBAR is sent to an alias derived from a user’s key, Hedera auto-creates the account.
- **What you need**:
  - A user-generated keypair (client-side, non-custodial)
  - An alias (ED25519 public key alias or EVM 0x alias)
  - A payer (on-ramp or user) to send HBAR to that alias

### Recommended Flows

#### 1) Pure Non-Custodial (Production)
1. Client generates ED25519 keypair locally (keep private key on device).
2. Derive alias (ED25519 alias or EVM 0x address) and send alias + public key to backend.
3. Payment provider sends HBAR to the alias.
4. Backend polls mirror node to resolve alias → `accountId` and marks wallet ready.

Pros: No backend keys or funds; fully non-custodial.

#### 2) Backend-Assisted Funding (Testnet/Dev Only)
If the on-ramp cannot send to testnet, maintain a small testnet funding wallet to send a tiny HBAR to the user alias to trigger auto-creation. Do not use this for production custody without full key management and compliance.

### Client: Generate Keys and Aliases (TypeScript)

```ts
import { PrivateKey, EvmAddress } from "@hashgraph/sdk";
import { keccak256 } from "js-sha3"; // only needed if deriving EVM address

// 1) Generate ED25519 keys locally (NEVER exfiltrate private key)
const privateKey = PrivateKey.generateED25519();
const publicKey = privateKey.publicKey;

// 2a) ED25519 alias AccountId (shard=0, realm=0)
const ed25519AliasAccountId = publicKey.toAccountId(0, 0); // e.g., "0.0.<alias>"

// 2b) Optional EVM alias (0x...)
const evmAddrHex = keccak256(publicKey.toBytesRaw()).slice(24 * 2); // last 20 bytes
const evmAddress = EvmAddress.fromString("0x" + evmAddrHex);

// Provide the alias to the backend / on-ramp; never the private key.
```

Notes:
- Prefer ED25519 alias unless your UX/stack expects EVM addresses.
- Store private keys in secure device storage (Keychain/Keystore/Secure Enclave).

### Backend: Collect Payment and Confirm Account Creation
- Provide the user’s alias as the destination to Banxa/Alchemy Pay or display it for direct crypto.
- After webhook confirmation, poll the mirror node to find the new `accountId`.

Mirror node examples:

```bash
# EVM alias → account
GET https://testnet.mirrornode.hedera.com/api/v1/accounts?evm_address=0xEvmAlias

# ED25519 public key (DER) → account
GET "https://testnet.mirrornode.hedera.com/api/v1/accounts?account.publickey=302a300506032b6570..."
```

Once returned, persist `0.0.xxxxxxx` with the user.

### Optional (Testnet/Dev): Trigger with a Small Transfer

```ts
import { Client, AccountId, PrivateKey, TransferTransaction, Hbar } from "@hashgraph/sdk";

const client = Client.forTestnet();
client.setOperator(
  AccountId.fromString(process.env.TEST_OPERATOR_ID!),
  PrivateKey.fromString(process.env.TEST_OPERATOR_KEY!)
);

// Send small HBAR to user alias to trigger creation
await new TransferTransaction()
  .addHbarTransfer(AccountId.fromString(process.env.TEST_OPERATOR_ID!), new Hbar(-1))
  .addHbarTransfer(AccountId.fromString(ed25519AliasAccountId.toString()), new Hbar(1))
  .execute(client)
  .then(tx => tx.getReceipt(client));
```

Security: Keep this pattern to testnet/dev. In production rely on payer sending to the alias.

### Webhooks (Banxa/Alchemy Pay)
- Verify signatures and ensure idempotency (e.g., `payment_id`).
- Confirm the on-chain transfer went to the user alias.
- If provider sent to alias, wait for mirror node to show the account; otherwise (testnet/dev) trigger your own small transfer.
- Mark wallet active when `accountId` is known and balance > 0.

### Endpoints and Networks
- Testnet mirror: `https://testnet.mirrornode.hedera.com/api/v1`
- Mainnet mirror: `https://mainnet-public.mirrornode.hedera.com/api/v1`
- Use Hedera SDK only when your backend needs to submit a transaction (not needed for pure non-custodial flow).

### Compliance and Ops
- Never transmit private keys to the backend.
- Backoff and rate-limit mirror polling; handle delayed finality.
- Keep immutable alias ↔ accountId mapping once resolved.
- Monitor failed/partial payments and insufficient fees.

### TL;DR
- Generate keys client-side; derive an alias (ED25519 or EVM).
- Payer sends HBAR to the alias; Hedera auto-creates the account.
- Backend listens for webhook and resolves alias → `accountId` via mirror node.
- No operator in production; optional tiny testnet funding wallet for dev.






