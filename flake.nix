{ 
    description = "Bare-bones, incomplete Framework 13 flake. Using github:kjhoerr/dotfiles";

    inputs = {
        # nixpkgs.
        nixos-pkgs.url = "github:NixOS/nixpkgs";
        nixpkgs.url = "github:NixOS/nixpkgs";

        # home-manager for easier user config.
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };    

    outputs = { nixpkgs, ... }@inputs:
        let
            # system = "x86_64-linux";
            lib = inputs.nixos-pkgs.lib;
            pkgs = import nixpkgs {
                # inherit system;
                config.allowUnfree = true;
            };

            modules = [
                ./src/configuration.nix
                ./src/hardware-configuration.nix
            ];

        in {
            nixosConfigurations = {
                motherbase = lib.nixosSystem [
                    modules   
                ];
            };
        };
}