{ lib, pkgs, modulesPath, config, ... }: {

  # system hardware 

  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "none";
      fsType = "tmpfs";
      neededForBoot = true;
    };
  
  fileSystems."/home/jalen" = {
	device = "none";
 	fsType = "tmpfs";
  };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/3D4B-08E0";
      fsType = "vfat";
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/0582ac0b-f25d-4449-bf90-954a2b36b3a6";
      fsType = "btrfs";
      options = [ "defaults" "compress-force=zstd" "noatime" "ssd" "subvol=nix" ];
      neededForBoot = true;
    };

  boot.initrd.luks.devices."root".device = "/dev/disk/by-uuid/5a95062b-04d0-4819-802b-6c80f81301b0";

  swapDevices =
    [ { device = "/dev/disk/by-uuid/4c514d5d-9a70-46bf-b33f-d8ca2b9d4a4e"; }
    ];

  
  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # required system persistence.
  environment.persistence."/nix/persist" = {
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
	];
  };

  # allow write-able mounts for users
  programs.fuse.userAllowOther = true;

  # Configuration.nix
  networking.hostName = "motherbase"; # Define your hostname.

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # net manager
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

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
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    /*openssh.authorizedKeys.keys = [
	''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPMPEwsk6NKKRoGXfWVdGfVsjA4+OXESgeYbDEUmi6uV ajalenboi@gmail.com'' # git pub key
    ];*/
    hashedPasswordFile = "/nix/persist/psk/jalen";
  };

  users.users.root.hashedPasswordFile = "/nix/persist/psk/root";

  # users.users.root.initialHashedPassword = "$y$j9T$MGafuHlTpjb7L.zur1vsn.$Hmk5kOeaNWUqSs1LK49ej0kmt..1wbrsn612jF9tO1.";
  # users.users.jalen.initialHashedPassword = "$y$j9T$MGafuHlTpjb7L.zur1vsn.$Hmk5kOeaNWUqSs1LK49ej0kmt..1wbrsn612jF9tO1.";

  system.stateVersion = "23.11"; 
  nix.settings.experimental-features = "nix-command flakes";
}
