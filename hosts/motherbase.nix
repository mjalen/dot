{ lib, pkgs, ... }: {

  boot.initrd.availableKernelModules = [ "xhci_pci" "usbhid" "sr_mod" ];
  boot.initrd.kernelModules = [ "nvme" "usb_storage" "sd_mod" ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/a91b524e-36e4-45ed-9215-2a2cf3296503";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/08F9-86E4";
      fsType = "vfat";
    };

  swapDevices = [ 
      { device = "/dev/disk/by-uuid/bac1474b-2ad2-4226-9503-fdc28ee073ee"; }
    ];

  # dhcp 
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s5.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
  hardware.parallels.enable = true;
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "prl-tools" ];

  # Configuration.nix
  networking.hostName = "motherbase"; # Define your hostname.

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  services.automatic-timezoned.enable = true;  

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # host packages.
  environment.systemPackages = with pkgs; [ git ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;
  users.users.jalen = {
    isNormalUser = true;
    description = "Jalen Moore";
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
	''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPMPEwsk6NKKRoGXfWVdGfVsjA4+OXESgeYbDEUmi6uV ajalenboi@gmail.com'' # git pub key
    ];
    # eventually want to add hashedPasswordFile
  };

  system.stateVersion = "23.05"; 
  nix.settings.experimental-features = "nix-command flakes";
}
