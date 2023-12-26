{ 
    description = ''
      Jalen Moore's Nix configuration. 
      Currently targets two platforms: Framework 13 AMD 7640 and Parallels VM.
      Slowly stealing from github:kjhoerr/dotfiles
    '';

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
            # system = "x86_64-linux"; # For when the framework comes in!
            system = "aarch64-linux"; # parallels vm.
            pkgs = import nixpkgs {
                inherit system;
                config.allowUnfree = true;
            };

	    # modules that are auto-added to users (via home-manager).
            userSecurity = [ ./home/mod/gpg.nix ]; 

            newHomeUser = userModules: inputs.home-manager.lib.homeManagerConfiguration {
                inherit pkgs; 
                modules = (
		  userModules ++
		  userSecurity
		);
            };

	    # system modules (NixOS)
            hosts = [ ./hosts/motherbase.nix ]; 
	    security = [ ./services/ssh.nix ];

        in {

            # remember $ nix build .#homeConfigurations.<user>.activationPackage 
            # and $ result/activate
            homeConfigurations = {
                jalen = newHomeUser [ ./home/jalen.nix ];
            };

            nixosConfigurations = {
		motherbase = nixpkgs.lib.nixosSystem {
	            modules = hosts ++ security;
		};
            };
        };
}
