{ inputs, lib, pkgs, ... }: 

with inputs;

let
	persistDir = "/nix/persist";	
in
{
	imports = [
		inputs.nixos-hardware.nixosModules.framework-13-7040-amd
		./persist.nix
		./virt-manager.nix
	];

	# enable persistance
	valhalla.persist = {
		enable = true;
		inherit persistDir;
	};

	services.fwupd.enable = true;

	# Configuration.nix
	networking.hostName = "valhalla"; # Define your hostname.

	# Use the systemd-boot EFI boot loader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	# net manager
	networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

	# bluetooth
	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;

	services.automatic-timezoned.enable = true;  

	# Enable sound.
	sound.enable = true;
	hardware.pulseaudio.enable = true;

	# host packages.
	environment.systemPackages = with pkgs; [ git vim ];

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.mutableUsers = false;
	users.users.jalen = {
		isNormalUser = true;
		description = "Jalen Moore";
		home = "/home/jalen";
		extraGroups = [ "wheel" "networkmanager" "lxd" "libvirtd" ]; # Enable ‘sudo’ for the user.

		# eventually want to add hashedPasswordFile
		hashedPasswordFile = "${persistDir}/psk/jalen";
	};

	users.users.root.hashedPasswordFile = "${persistDir}/psk/root";

	# hyprland is the GUI of choice
	programs.hyprland.enable = true;

	# hyprland requires /tmp/hypr to start, so create this
	systemd.tmpfiles.rules = [
		"d /tmp/hypr 0755 jalen users -" # cleanup is done on reboot through root wipe.
	];

	# Font rendering
	fonts = {
		fontconfig = {
			antialias = true;
			cache32Bit = true;
			hinting.enable = true;
			hinting.autohint = true;
		};
	};

	system.stateVersion = "23.11"; 
	nix.settings.experimental-features = "nix-command flakes";
}
