# Bridge 

# The following is the bridge file ~nixosBridge.nix~ between the flake and the host configurations. This file returns the NixOS system for each host. Currently there is only one host:

# - *valhalla*: Host for my Framework 13 AMD laptop.


# [[file:../Config.org::*Bridge][Bridge:1]]
{ inputs, pkgs, ...}:

with inputs; 

let 
	inherit (nixpkgs.lib) nixosSystem;
	inherit (pkgs) lib;	

	valhallaModules = [
		./nixos.nix
		impermanence.nixosModules.impermanence
	];
in {
	valhalla = nixosSystem {
		inherit pkgs;
		specialArgs = { inherit inputs; };
		modules = valhallaModules;
	};
}
# Bridge:1 ends here
