{ inputs, system, pkgs, ...}:

with inputs; 

let 
	inherit (nixpkgs.lib) nixosSystem;
	inherit (pkgs) lib;	

	valhallaModules = [
		./conf/valhalla.nix
		./hardware/valhalla.nix
		./services/ssh.nix
		impermanence.nixosModules.impermanence
	];
in {
	valhalla = nixosSystem {
		inherit lib pkgs system;
		specialArgs = { inherit inputs; };
		modules = valhallaModules;
	};
}
