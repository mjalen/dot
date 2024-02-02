# Bridge

# Bridge from the ~nix flake~ to each individual ~home-manager~ configuration. Below is the ~homeBridge.nix~ file.


# [[file:../Config.org::*Bridge][Bridge:1]]
{ self, inputs, pkgs, ... }: 

let
	sharedModules = [
		inputs.impermanence.nixosModules.home-manager.impermanence
	];

	homeImports = {
		jalen = [ ./home.nix ] ++ sharedModules;
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
