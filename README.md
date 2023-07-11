# Query Lido Operators
This is used to query the operator public keys from the Lido `NodeOperatorRegistry`

## Usage
Please run `forge script script/Query.s.sol --rpc-url $GOERLI_RPC_URL`. Please run this locally on a Goerli node or else the latency will kill you. Forge scripts make actual storage requests in series rather than RPC calls.
