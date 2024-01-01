{ inputs, pkgs, ...}:

with inputs; 

let 
	inherit (nixpkgs.lib) nixosSystem;
	inherit (pkgs) lib;	

	valhallaModules = [
		./conf/valhalla.nix
		./hardware/valhalla.nix
		./services/ssh.nix
		
		# ./services/lxc.nix # unpriviledged containers. (as opposed to nixos-containers)
		impermanence.nixosModules.impermanence
	];
in {
	valhalla = nixosSystem {
		inherit pkgs;
		specialArgs = { inherit inputs; };
		modules = valhallaModules;
	};
}
