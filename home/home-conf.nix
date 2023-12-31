{ inputs, system, pkgs, ... }: 

with inputs;

let
	imports = [
		impermanence.nixosModules.home-manager.impermanence
		# anyrun.homeManagerModules.default
		./users/jalen.nix
	];

	jalen = home-manager.lib.homeManagerConfiguration {
		inherit pkgs;
		modules = [{ inherit imports; }];
	};	
in {
	inherit jalen;
}
