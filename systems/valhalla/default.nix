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
		encryptedPARTUUID = "0b8863dc-bb89-4216-b019-dfe251754fc6";
		bootUUID = "A574-0836";
		unencryptedUUID = "8056629c-afc3-4deb-9772-b0c65f981f49";
	};
}
