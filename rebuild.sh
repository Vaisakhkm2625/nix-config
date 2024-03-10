#!/bin/bash
set -e
pushd ~/nix-config/
#nvim oatman-pc.nix
alejandra . &>/dev/null
git diff -U0 *.nix
echo "NixOS Rebuilding..."
sudo nixos-rebuild switch --flake .#nixos &>nixos-switch.log || (
	cat nixos-switch.log | grep --color error && false
)
gen=$(nixos-rebuild list-generations | grep current)
git commit -am "$gen"
popd
