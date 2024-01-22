{ config, inputs, lib, pkgs, ... }: {
	imports = [
		./hardware/valhalla.nix
		./conf/valhalla
		./services/ssh.nix
	];

	# DO NOT EDIT THESE UNLESS YOU ARE INSTALLING NIXOS!
	# See installation guide in README on how to derive the UUIDs.
	valhalla.hardware = {
		enabled = true;
		encryptedPARTUUID = "9c41d5e1-8b1f-42cb-8bdc-8edd51973791";
		headerPARTUUID = "23a9e2b8-d901-411a-a5f9-ea893072a5f4";
		bootUUID = "9119-329E";
		unencryptedUUID = "534cebad-1be2-4bdb-982d-835da3f6240a";
	};
}
