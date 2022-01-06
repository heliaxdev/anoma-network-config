# Anoma networks configuration

The directory `src` contains the source genesis files:

- `anoma-feigenbaum-0.toml` - public testnet "Feigenbaum"
- `anoma-devnet.toml` - Anoma devs internal testnet

From the source genesis files, we generate the final genesis files, chain ID and configurations for validators. This also generates all the keys and addresses that haven't been pre-filled in the source.

The final network configurations are published via [anoma-network-config GitHub releases](https://github.com/heliaxdev/anoma-network-config/releases). A release archive's directory contains sub-directories whose names are their chain IDs (e.g. `anoma-feigenbaum-0.9aad723f605`). Each of these directories contain the public part of the configuration:

- `.anoma/global-config/toml` - sets the default chain ID for Anoma
- `.anoma/{chain_id}.toml` - the final genesis file
- `.anoma/{chain_id}/config.toml` - Anoma ledger and intent gossip config for the chain
- `wasm/checksums.json` - The checksums of pre-built WASM transactions and validity predicates

The wallets, configs and Tendermint keys for validators and other accounts are in `.anoma/{chain_id}/setup`.

To generate a network config from a source genesis file using anomac (to avoid any compatibility issues, this should be the same release that will be used in the network):

```shell
anomac utils init-network \
    --chain-prefix anoma-feigenbaum-0 \
    --genesis-path src/anoma-feigenbaum-0.toml \
    --wasm-checksums-path ../anoma/wasm/checksums.json
```

Increment the version in the last char of `--chain-prefix` for each new testnet version.

The WASM checksums should point to the Anoma repository directory with the same branch as what's used for the release.

The command will create an archive of the public configuration for the generated network, e.g.:

```shell
Release archive created at {archive_file_path}
```

Use it in the following commands.

To test run release:

```shell
./release.sh {archive_file_path} --draft
```

To tag the master branch and upload the release archive created by `init-network` command, run:

```shell
./release.sh {archive_file_path}
```

For devnet use pre-release:

```shell
./release.sh {archive_file_path} --prerelease
```
