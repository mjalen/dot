{ inputs, pkgs, ...}:

with inputs; 

let 
	inherit (nixpkgs.lib) nixosSystem;
	inherit (pkgs) lib;	

	valhallaModules = [
		# ./conf/valhalla
		# ./hardware/valhalla.nix
		# ./services/ssh.nix

		# moved to a config file so it is (hopefully) easier to install on new systems with some quick tweaks.
		./config.nix 
		
		# load from inputs
		impermanence.nixosModules.impermanence
	];
in {
	valhalla = nixosSystem {
		inherit pkgs;
		specialArgs = { inherit inputs; };
		modules = valhallaModules;
	};
}
