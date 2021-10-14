# anoma-network-config
anoma network configuration

The directory `test/feigenbaum` contains the source genesis files:

- `internal-testnet.toml`
- `public-testnet.toml`

From the source genesis files, we generate the final genesis file, chain ID and configurations for validators. This also generates all the keys and addresses that haven't been pre-filled in the source.

The sub-directories with the same name as the source TOML files in `test/feigenbaum` then contain the public part of the configuration:

- `.anoma/global-config/toml` - sets the default chain ID for Anoma
- `.anoma/{chain_id}.toml` - the final genesis file
- `.anoma/{chain_id}/config.toml` - Anoma ledger and intent gossip config for the chain

The wallets, configs and Tendermint keys for validators and other accounts are in `.anoma/{chain_id}/setup`.

To generate a network config from a source genesis file using anomac (this should be the same release that will be used in the network):

```shell
anomac utils init-network \
    --genesis-path ~/dev/anoma-network-config/test/feigenbaum/public-testnet.toml \
    --chain-prefix anoma-feigenbaum-0 \
    --unsafe-dont-encrypt
```

Increment the version in the last char of `--chain-prefix` for each new testnet chain.
