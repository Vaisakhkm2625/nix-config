{ pkgs ? import <nixpkgs> { } }:
pkgs.writeShellScriptBin "nixos-outdated" ''
  nixos-rebuild dry-build 2>&1 \
    | ${pkgs.gnugrep}/bin/grep /nix/store \
    | ${pkgs.coreutils}/bin/cut -d '/' -f 4 \
    | ${pkgs.coreutils}/bin/cut -d '-' -f 2- \
    | ${pkgs.coreutils}/bin/sort
''
