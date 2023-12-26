{ 
    description = "Bare-bones, incomplete Framework 13 flake. Using github:kjhoerr/dotfiles";

    inputs = {
        # nixpkgs.
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

        # home-manager for easier user config.
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };    

    outputs = { self, nixpkgs, ... }@inputs:
        let
            # system = "x86_64-linux";
            system = "aarch64-linux";
            pkgs = import nixpkgs {
                inherit system;
                config.allowUnfree = true;
            };

            newHomeUser = (userModules: inputs.home-manager.lib.homeManagerConfiguration {
                inherit pkgs; 
                modules = userModules; # add default modules with ++.
            });

            hosts = [ ./hosts/motherbase.nix ]; 

        in {
            homeConfigurations = {
                jalen = newHomeUser [ ./home/jalen.nix ];
            };

            nixosConfigurations = {
                motherbase = nixpkgs.lib.nixosSystem { 
                    modules = hosts;   
                };
            };
        };
}