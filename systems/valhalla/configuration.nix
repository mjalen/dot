{ inputs, lib, pkgs, ... }:

let
	persistDir = "/persist";
in
{
  imports = [
	  inputs.nixos-hardware.nixosModules.framework-13-7040-amd
	  ./persist.nix	
	  ./pipewire.nix
	  ./virt-manager.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "valhalla"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  services.automatic-timezoned.enable = true;

  # enable persistence
  valhalla.persist = {
	  enable = true;
	  inherit persistDir;
  };

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
