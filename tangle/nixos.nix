# NixOS and Home Manager

# Here is where it gets interesting. Below are _incomplete_ ~nix~ files, which we will populate as we progress. For now, we are describing the framework we are working with. The ~concatAttr~ function takes a list of attribute sets and returns the the concatenation of each set. This approach was chosen to avoid file management problems, and to also forego the NixOS modules system /nearly/ in its entirety; it is simply to much gross boiler-plate for my liking.

# The following is our ~nixos.nix~ file.


# [[file:../Config.org::*NixOS and Home Manager][NixOS and Home Manager:1]]
{ config, inputs, pkgs, lib, ... }:
let
  concatAttr = list: builtins.foldl' (a: b: a // b) {} list;
in

concatAttr [
# NixOS and Home Manager:1 ends here

# SSH


# [[file:../Config.org::*SSH][SSH:1]]
{
  services.openssh = {
		enable = true;
		settings = {
			PasswordAuthentication = false;
			KbdInteractiveAuthentication = false;
		};
	};
}
# SSH:1 ends here

# Configuration

# Configuration analogous to the standard configuration generated during NixOS installation.


# [[file:../Config.org::*Configuration][Configuration:1]]
{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "valhalla"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  services.automatic-timezoned.enable = true;

  # hyprland is the GUI of choice
  programs.hyprland.enable = true;

  # hyprland requires /tmp/hypr to start, so create this
  systemd.tmpfiles.rules = [
	  "d /tmp/hypr 0755 jalen users -" # cleanup is done on reboot through root wipe.
  ];

  # users
  users.mutableUsers = false;
  users.users.root.hashedPasswordFile = "${persistDir}/psk/root";
  users.users.jalen = {
	  isNormalUser = true;
 	  home = "/home/jalen";
	  extraGroups = [ "wheel" "networkmanager" ];
 	  hashedPasswordFile = "${persistDir}/psk/jalen";
	  # packages = with pkgs; [ git vim wget ];
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ vim wget git ];

  system.stateVersion = "23.11"; # Did you read the comment?
  nix.settings.experimental-features = "nix-command flakes";
}
# Configuration:1 ends here

# Hardware

# My hardware configuration for the Framework 13 laptop. During installation, it is *necessary* to update the PARTUUIDs and UUIDs. Follow the ~README.org~ installation guide for how to update these identifiers. 


# [[file:../Config.org::*Hardware][Hardware:1]]
(
  with lib;
  let
    encryptedPARTUUID = "d2ce0233-c9d7-406a-9847-107ad0f0e3f7";
		headerPARTUUID = "ab616024-7d8c-44e5-84da-e363e20781a6";
		bootUUID = "5251-7E3F";
		unencryptedUUID = "69ff994b-9f9d-4014-870f-964273c7944e";
  in
    {
		  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usb_storage" "sd_mod" ];
		  boot.initrd.kernelModules = [ ];
		  boot.kernelModules = [ "kvm-amd" ];
		  boot.extraModulePackages = [ ];

		  fileSystems."/" =
		    { device = "/dev/disk/by-uuid/${unencryptedUUID}";
		      fsType = "btrfs";
		      options = [ "subvol=root" ];
		    };

		  # luks boot info
		  boot.initrd.luks.devices = {
			  crypted = {
				  device = "/dev/disk/by-partuuid/${encryptedPARTUUID}"; # 9c41d5e1-8b1f-42cb-8bdc-8edd51973791
				  header = "/dev/disk/by-partuuid/${headerPARTUUID}"; # 23a9e2b8-d901-411a-a5f9-ea893072a5f4 
				  allowDiscards = true;
				  preLVM = true;
			  };
		  };

		  fileSystems."/persist" =
		    { device = "/dev/disk/by-uuid/${unencryptedUUID}";
		      fsType = "btrfs";
		      neededForBoot = true;
		      options = [ "subvol=persist" ];
		    };

		  fileSystems."/nix" =
		    { device = "/dev/disk/by-uuid/${unencryptedUUID}";
		      fsType = "btrfs";
		      options = [ "subvol=nix" ];
		    };

		  fileSystems."/boot" =
		    { device = "/dev/disk/by-uuid/${bootUUID}";
		      fsType = "vfat";
		    };

		  swapDevices = [ ];

		  boot.initrd.postDeviceCommands = lib.mkAfter ''
			mkdir /btrfs_tmp
			mount /dev/disk/by-uuid/${unencryptedUUID} /btrfs_tmp
			if [[ -e /btrfs_tmp/root ]]; then
				mkdir -p /btrfs_tmp/backups
				timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
				mv /btrfs_tmp/root "/btrfs_tmp/backups/$timestamp"
			fi

			delete_subvolume_recursively() {
				IFS=$'\n'
				for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
					delete_subvolume_recursively "/btrfs_tmp/$i"
				done
				btrfs subvolume delete "$1"
			}

			for i in $(find /btrfs_tmp/backups/ -maxdepth 1 -mtime +30); do
				delete_subvolume_recursively "$i"
			done

			btrfs subvolume create /btrfs_tmp/root
			umount /btrfs_tmp
		'';

		  networking.useDHCP = lib.mkDefault true;
		  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
		  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    }
)
# Hardware:1 ends here

# Impermanence

# I explained why we are using impermanence in the ~README.org~. If you need my reasonings, I suggest you look there.


# [[file:../Config.org::*Impermanence][Impermanence:1]]
(
  let
	  persistDir = "/persist";
  in
    {
		  environment.persistence."${persistDir}" = {
			  hideMounts = true;
			  directories = [
				  "/var/log"
				  "/var/lib/bluetooth"
				  "/var/lib/nixos"
				  "/var/lib/systemd/coredump"
				  "/etc/ssh"
				  "/etc/NetworkManager"
				  "/etc/nixos"
			  ];
			  files = [
				  "/etc/nix/id_rsa"
				  "/etc/machine-id"
				  "/etc/systemd/resolved.conf" # using nextdns
			  ];
			  users.jalen = {
				  directories = [
					  "Documents"
					  ".local/state/nix/profiles"
					  ".ssh"
					  ".gnupg"
					  "Pictures"
					  "Music"
					  "VMs"
					  ".emacs.d" # I don't want to sit forever while emacs installs everything.
					  # TODO create an emacs package manifest
				  ];
			  };
		  };
	  }
)
# Impermanence:1 ends here

# Pipewire

# For microphones.


# [[file:../Config.org::*Pipewire][Pipewire:1]]
{
  security.rtkit.enable = true;
	services.pipewire.pulse.enable = true;
}
# Pipewire:1 ends here

# Virt Manager


# [[file:../Config.org::*Virt Manager][Virt Manager:1]]
{
	virtualisation.libvirtd.enable = true;
	programs.virt-manager.enable = true;
}
# Virt Manager:1 ends here

# Finishing Touch

# To finish off our NixOS configuration, we need to end our preamble configuration!


# [[file:../Config.org::*Finishing Touch][Finishing Touch:1]]
]
# Finishing Touch:1 ends here
