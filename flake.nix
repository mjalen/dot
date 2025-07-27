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

  outputs = inputs@{
    self,
    nixpkgs,
    nur,
    niri,
    ...
   }: let
        system = "x86_64-linux";
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
	        overlays = [
            nur.overlays.default
            niri.overlays.niri
          ];
        };
    in {
        nixosConfigurations = {
          valhalla = inputs.nixpkgs.lib.nixosSystem {
              inherit pkgs;
              specialArgs = { inherit inputs; };
              modules = [
        		    inputs.impermanence.nixosModules.impermanence
      		      inputs.nixos-hardware.nixosModules.gpd-pocket-4
                inputs.niri.nixosModules.niri
  		          ./system
              ];
          };
        };
        homeConfigurations = {
          jalen = inputs.home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = {
              inherit inputs self;
              wallpaper = ./assets/frieren_doll.jpg;
            };
            modules = [
              inputs.impermanence.nixosModules.home-manager.impermanence
              inputs.niri.homeModules.niri
  	          inputs.catppuccin.homeModules.catppuccin
              ./home
            ];
          };
        };
        formatter.x86_64-linux = pkgs.nixpkgs-fmt;
      };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    impermanence.url = "github:nix-community/impermanence";
    nil.url = "github:oxalica/nil";
    niri.url = "github:sodiboo/niri-flake";
  	catppuccin.url = "github:catppuccin/nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
