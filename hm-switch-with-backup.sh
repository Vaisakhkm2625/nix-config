#export NIXPKGS_ALLOW_INSECURE=1
export NIXPKGS_ALLOW_BROKEN=1
export NIXPKGS_ALLOW_UNFREE=1

home-manager switch -b backup --flake .#vaisakh@nixos --impure
