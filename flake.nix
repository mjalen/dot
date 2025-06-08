/*
             __
            ( o`-
            /  \
            |  |
             ^^ BP

  	 NixOS Config
  		by Jalen Moore
*/

{
  description = ''Jalen Moore's Nix configuration.'';

  outputs = { self, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          inputs.nur.overlay
        ];
      };
    in
    {
      nixosConfigurations = {
        valhalla = inputs.nixpkgs.lib.nixosSystem {
            inherit pkgs;
            specialArgs = { inherit inputs; };
            modules = [
            ./systems/valhalla
            inputs.impermanence.nixosModules.impermanence
            ];
        };
      };
      # nixosConfigurations = import ./systems { inherit inputs pkgs self; };
      homeConfigurations = import ./home { inherit inputs pkgs self; };
      formatter.x86_64-linux = pkgs.nixpkgs-fmt;
    };

  inputs = {
    # nixpkgs.
    nixpkgs.url = "github:NixOS/nixpkgs";

    # hardware (for framework 13 - AMD 7040)
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # home-manager for easier user config.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # impermanence (I only keep /nix on reboot. Any persisting documents are stored in /nix/persist.)
    impermanence = {
      url = "github:nix-community/impermanence";
    };

    # nix lsp
    nil.url = "github:oxalica/nil";

    # nur
    nur = {
      url = "github:nix-community/NUR";
    };

    # emacs config
    # emacs.url = "github:mjalen/emacs";
  };
}
