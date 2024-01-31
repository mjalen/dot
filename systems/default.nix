{ inputs, pkgs, ...}:

with inputs; 

let 
	inherit (nixpkgs.lib) nixosSystem;
	inherit (pkgs) lib;	

	valhallaModules = [
		./valhalla 
		impermanence.nixosModules.impermanence
	];
in {
	valhalla = nixosSystem {
		inherit pkgs;
		specialArgs = { inherit inputs; };
		modules = valhallaModules;
	};
}
