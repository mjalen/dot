# Bridge

# Bridge from the ~nix flake~ to each individual user ~home-manager~ configuration.


# [[file:../Config.org::*Bridge][Bridge:1]]
{ self, inputs, pkgs, ... }: 

let
	sharedModules = [
		inputs.impermanence.nixosModules.home-manager.impermanence
	];

	homeImports = {
		jalen = [ ./user.nix ] ++ sharedModules;
	};

	inherit (inputs.home-manager.lib) homeManagerConfiguration;
in {
	jalen = homeManagerConfiguration {
		inherit pkgs;
		extraSpecialArgs = { inherit inputs self; };
		modules = homeImports.jalen;
	}; 
}
# Bridge:1 ends here
