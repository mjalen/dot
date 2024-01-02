/* 
Good references:
	gvolpe/nix-config
	kjhoerr/dotfiles
*/

{ 
    description = ''
      Jalen Moore's Nix configuration. 
    '';

    outputs = inputs:
        let
            system = "x86_64-linux";
            pkgs = import inputs.nixpkgs {
                inherit system;
                config.allowUnfree = true;
                overlays = [ inputs.nur.overlay ];
            };
        in {
            nixosConfigurations = import ./systems { inherit inputs pkgs; };
            homeConfigurations = import ./home { inherit inputs pkgs; };
        };

    inputs = {
        # nixpkgs.
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

	# hardware
	nixos-hardware.url = "github:NixOS/nixos-hardware/master";

        # flake-parts
        # parts.url = "github:hercules-ci/flake-parts";

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

	    # vscode server. not really sure if I need this. I believe it is for remote ssh which I do not currently use (but will in the future).
	    vscode-server = {
	    	url = "github:nix-community/nixos-vscode-server";
	    	inputs.nixpkgs.follows = "nixpkgs";
	    };
    };    
}
