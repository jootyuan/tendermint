#! /bin/bash

PKGS=$(go list github.com/tendermint/tendermint/... | grep -v /vendor/)

set -e
echo "mode: atomic" > coverage.txt
for pkg in ${PKGS[@]}; do
	go test -v -timeout 30m -race -coverprofile=profile.out -covermode=atomic $pkg
	if [ -f profile.out ]; then
		tail -n +2 profile.out >> coverage.txt;
		rm profile.out
	fi
done
