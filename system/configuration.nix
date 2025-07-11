{ inputs, pkgs, ... }:

let
  persistDir = "/persist";
in
{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "valhalla"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  # services.automatic-timezoned.enable = true;
  time.timeZone = "America/Chicago";

  # ppd
  services.power-profiles-daemon.enable = true;

  # enable persistence
  valhalla.persist = {
    enable = true;
    inherit persistDir;
  };

  # gnupg
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
    enableSSHSupport = true;
#     settings = {
#       allow-loopback-entry = true;
#     };
  };

  # hyprland is the GUI of choice
  programs.hyprland.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

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
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ vim wget git ];

#  
#   services.udev.extraHwdb = ''
# sensor:modalias:acpi:MXC6655*:dmi:*:svnGPD:pnG1621-02:*
#  ACCEL_MOUNT_MATRIX=-1, 0, 0; 0, 1, 0; 0, 0, 1
#   '';

  system.stateVersion = "25.05"; # Did you read the comment?
  nix.settings.experimental-features = "nix-command flakes";
}
