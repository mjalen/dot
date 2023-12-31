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

    outputs = { nixpkgs, nur, anyrun, ... }@inputs:
        let
            system = "x86_64-linux";
            pkgs = import nixpkgs {
                inherit system;
                inherit anyrun;
                config.allowUnfree = true;
                overlays = [ nur.overlay ];
            };
        in 
        {
            # separate so I do not have to constantly build NixOS config.
            homeConfigurations = import ./home/home-conf.nix { inherit inputs system pkgs; };
            nixosConfigurations = import ./systems/nixos-conf.nix { inherit inputs system pkgs; };
        };
}
