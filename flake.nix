/* 
Good references:
	gvolpe/nix-config
	kjhoerr/dotfiles
*/

{ 
    description = ''
      Jalen Moore's Nix configuration. 
    '';

    inputs = {
        # nixpkgs.
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

        # home-manager for easier user config.
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

	# impermanence (I only keep /nix on reboot. Any persisting documents are stored in /nix/persist.)
	impermanence = {
		url = "github:nix-community/impermanence";
	};

	# vscode server
	vscode-server = {
		url = "github:nix-community/nixos-vscode-server";
		inputs.nixpkgs.follows = "nixpkgs";
	};
    };    

    outputs = { nixpkgs, home-manager, ... }@inputs:
        let
            system = "x86_64-linux";
            pkgs = import nixpkgs {
                inherit system;
                config.allowUnfree = true;
            };

        in {
	    # I am separating these configs out, so when I edit I don't get confused where changes will end up (since the builds for these are separate).
	    homeConfigurations = import ./home/home-conf.nix { inherit inputs system pkgs; };
	    nixosConfigurations = import ./systems/nixos-conf.nix { inherit inputs system pkgs; };
        };
}
