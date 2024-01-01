{ inputs, pkgs, ... }: 

let
	sharedModules = [
		inputs.impermanence.nixosModules.home-manager.impermanence
		inputs.anyrun.homeManagerModules.default
	];

	homeImports = {
		jalen = [./users/jalen ] ++ sharedModules;
	};

	inherit (inputs.home-manager.lib) homeManagerConfiguration;
in {
	jalen = homeManagerConfiguration {
		inherit pkgs;
		extraSpecialArgs = { inherit inputs; };
		modules = homeImports.jalen;
	}; 
}
