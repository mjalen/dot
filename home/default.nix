{ self, inputs, pkgs, withSystem, ... }: 

let
	sharedModules = [
		inputs.impermanence.nixosModules.home-manager.impermanence
		inputs.anyrun.homeManagerModules.default
	];

	homeImports = {
		"jalen@valhalla" = [./users/jalen.nix] ++ sharedModules;
	};

	inherit (inputs.home-manager.lib) homeManagerConfiguration;
in {
	imports = [
		{_module.args = { inherit homeImports; }; }
	];

	flake.homeConfigurations = withSystem "x86_64-linux" ({pkgs, inputs', ...}: {
		let
			
		in
		"jalen@valhalla" = homeManagerConfiguration {
			inherit pkgs;
			extraSpecialArgs = {
				inherit inputs inputs';
			};
			modules = homeImports."jalen@valhalla";
		}; 
	});
}
