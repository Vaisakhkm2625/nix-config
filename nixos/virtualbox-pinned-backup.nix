

# check new version commit ids from
# https://lazamar.co.uk/nix-versions/?channel=nixpkgs-unstable&package=virtualbox


{ config, pkgs, ... }:

let
  pinnedPkgs = import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/21808d22b1cda1898b71cf1a1beb524a97add2c4.tar.gz";
    sha256 = "0v2z6jphhbk1ik7fqhlfnihcyff5np9wb3pv19j9qb9mpildx0cg";
    
  }) {
      system = pkgs.system;
      config.allowUnfree = true;
    };
in
{

  options = {};
  config = {


    

    environment.systemPackages = with pinnedPkgs; [
      virtualbox
      virtualboxExtpack
    ];


    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = ["user-with-access-to-virtualbox"];
    virtualisation.virtualbox.host.enableExtensionPack = true;


  };
}
