{ config, inputs, lib, pkgs, ... }: {
	imports = [
		./hardware-configuration.nix
		./configuration.nix
		../services/ssh.nix
	];

	# DO NOT EDIT THESE UNLESS YOU ARE INSTALLING NIXOS!
	# See installation guide in README on how to derive the UUIDs.
	valhalla.hardware = {
		enabled = true;
		encryptedPARTUUID = "d2ce0233-c9d7-406a-9847-107ad0f0e3f7";
		headerPARTUUID = "ab616024-7d8c-44e5-84da-e363e20781a6";
		bootUUID = "5251-7E3F";
		unencryptedUUID = "69ff994b-9f9d-4014-870f-964273c7944e";
	};
}
