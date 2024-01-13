/*
             __
            ( o`-
            /  \
            |  |
             ^^ BP

	 NixOS Config 
		by Jalen Moore

	references:
	 - gvolpe/nix-config
	 - kjhoerr/dotfiles
*/

{ 
    description = ''Jalen Moore's Nix configuration.'';

    outputs = { self, flake-utils, ... } @ inputs:
		with flake-utils.lib; eachDefaultSystem (system:
			let
				pkgs = import inputs.nixpkgs {
					inherit system;
					config.allowUnfree = true;
					overlays = [ 
						inputs.nur.overlay
					];
				};
			in {
				nixosConfigurations = import ./systems { inherit inputs pkgs self; };
				homeConfigurations = import ./home { inherit inputs pkgs self; };
			}
		);

    inputs = {
        # nixpkgs.
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

		# flake utils
		# not sure I really need this, but its there I guess. Adds some untested system independence.
		flake-utils.url = "github:numtide/flake-utils";

		# hardware (for framework 13 - AMD 7040)
		nixos-hardware.url = "github:NixOS/nixos-hardware/master";

        # anyrun program launcher
        anyrun = {
            url = "github:Kirottu/anyrun";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # home-manager for easier user config.
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

	    # impermanence (I only keep /nix on reboot. Any persisting documents are stored in /nix/persist.)
	    impermanence = {
		    url = "github:nix-community/impermanence";
	    };

        # nur
        nur = {
            url = "github:nix-community/NUR";
        };

		# youtube-tui
		# youtube-tui.url = "github:Siriusmart/youtube-tui";
    };    
}
