#!/bin/bash

# Release a finalized network configuration.
# Must have authenticated `gh` available (see https://github.com/cli/cli) with
# write access to https://github.com/heliaxdev/anoma-network-config.
#
# The first argument is the chain ID.
# Important: Use pre-release for the devnet, add `--prerelease` flag at the end 
# when calling this script.
# To test run, add `--draft` flag at the end when calling this script.
#
# Tags the master branch with the chain ID and creates a GitHub release with
# the release archive, created by `anomac utils init-network` command. This file
# must be in the current working directory.

set -e

CHAIN_ID=$1
EXTRA_ARG=$2
echo "Chain ID: $CHAIN_ID"
CWD=$(pwd)
ARCHIVE="$CWD/$CHAIN_ID.tar.gz"

echo "Releasing from $ARCHIVE..."

if [ -n "$EXTRA_ARG" ] ; then
    gh release create "$CHAIN_ID" "$ARCHIVE" \
        --title "$CHAIN_ID" \
        --notes "Released network with chain ID: $CHAIN_ID" \
        --repo heliaxdev/anoma-network-config \
        "$EXTRA_ARG"
else
    gh release create "$CHAIN_ID" "$ARCHIVE" \
        --title "$CHAIN_ID" \
        --notes "Released network with chain ID: $CHAIN_ID" \
        --repo heliaxdev/anoma-network-config
fi