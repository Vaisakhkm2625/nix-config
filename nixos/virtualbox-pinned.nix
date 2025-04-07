{ config, pkgs, ... }:

let
  pinnedPkgs = import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/21808d22b1cda1898b71cf1a1beb524a97add2c4.tar.gz";
    sha256 = "0v2z6jphhbk1ik7fqhlfnihcyff5np9wb3pv19j9qb9mpildx0cg";
  }) {
    system = pkgs.system;
    config = {
      allowUnfree = true;
    };
  };
in
{
  config = {
    nixpkgs.config.allowUnfree = true;

    #environment.systemPackages = with pinnedPkgs; [
    #  virtualbox
    #];

    virtualisation.virtualbox.host.enable = true;
    virtualisation.virtualbox.host.enableExtensionPack = true;
  };
}
