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
		encryptedPARTUUID = "e65c3ef5-1abc-4f25-afda-6aec7f69bfd2";
		bootUUID = "BA82-BADE";
		unencryptedUUID = "8ecb750c-ad14-4f14-9566-1f317813064b";
	};
}
