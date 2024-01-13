{ self, inputs, pkgs, ... }: 

let
	sharedModules = [
		inputs.impermanence.nixosModules.home-manager.impermanence
		inputs.anyrun.homeManagerModules.default
	];

	# is this the best solution? No. But I'm trying it out.
	homeImports = {
		users = [ ./users ] ++ sharedModules ++ [
			{
				valhalla.users.enable = true;
				valhalla.users.users = [ "jalen" ];
			}
		];
	};

	inherit (inputs.home-manager.lib) homeManagerConfiguration;
in {
	users = homeManagerConfiguration {
		inherit pkgs;
		extraSpecialArgs = { inherit inputs self; };
		modules = homeImports.users;
	}; 
}
