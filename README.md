# Anoma networks configuration

The directory `src` contains the source genesis files:

- `anoma-public.toml` - public testnet
- `anoma-internal.toml` - internal testnet

From the source genesis files, we generate the final genesis files, chain ID and configurations for validators. This also generates all the keys and addresses that haven't been pre-filled in the source.

The `final` directory contains sub-directories whose names are their chain IDs (e.g. `anoma-feigenbaum-0.9aad723f605`). Each of these directories contain the public part of the configuration:

- `.anoma/global-config/toml` - sets the default chain ID for Anoma
- `.anoma/{chain_id}.toml` - the final genesis file
- `.anoma/{chain_id}/config.toml` - Anoma ledger and intent gossip config for the chain

The wallets, configs and Tendermint keys for validators and other accounts are in `.anoma/{chain_id}/setup`.

To generate a network config from a source genesis file using anomac (this should be the same release that will be used in the network):

```shell
anomac utils init-network \
    --genesis-path src/anoma-public.toml \
    --chain-prefix anoma-feigenbaum-0
```

Increment the version in the last char of `--chain-prefix` for each new testnet version.

The command will print the chain ID of the generated network. Use it in the following commands.

To test run release:

```shell
./release.sh {chain_id} --draft
```

To tag the master branch and upload the release archive created by `init-network` command, run:

```shell
./release.sh {chain_id}
```
