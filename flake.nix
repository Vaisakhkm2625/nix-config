{
  description = "My new nix config";

  inputs = {
    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # home manager
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # TODO: Add any other flake you might need
    # hardware.url = "github:nixos/nixos-hardware";
    xremap-flake.url = "github:xremap/nix-flake";
    pyprland-flake.url = "github:hyprland-community/pyprland";

    #yazi-flake.url = "github:sxyazi/yazi/";

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { nixpkgs, home-manager,nixpkgs-unstable, ... }@inputs: {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      # FIXME replace with your hostname (done)
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; }; # Pass flake inputs to our config
        # > Our main nixos configuration file <

        modules = [

# https://www.reddit.com/r/NixOS/comments/klbuu2/unstable_packages_in_configurationnix_using_flakes/
        ({ config, pkgs, ... }: 
         let
            overlay-unstable = final: prev: {
            unstable = nixpkgs-unstable.legacyPackages.x86_64-linux;
            };
         in
         {
            nixpkgs.overlays = [ overlay-unstable ]; 
            environment.systemPackages = with pkgs; [
                unstable.libsForQt5.sddm
                unstable.pyprland
                unstable.waybar
            ];
         }
        )
        ./nixos/configuration.nix 
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      # FIXME replace with your username@hostname (done)
      "vaisakh@nixos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = { 
            inherit inputs;
            }; # Pass flake inputs to our config
        # > Our main home-manager configuration file <
        modules = [ ./home-manager/home.nix ];
      };
    };
  };
}
