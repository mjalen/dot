{ pkgs, ... }:

let
  persistDir = "/persist";
in
{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModprobeConfig = ''
    options snd-intel-dspcfg dsp_driver=1
  '';

  networking.hostName = "valhalla"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # ppd
  # services.power-profiles-daemon.enable = true;

#   services.udev.enable = true;
#   services.udev.extraRules = ''
#    SUBSYSTEM=="power_supply", KERNEL=="BATT", ATTR{charge_control_end_threshold}="80"
# '';

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
    # enableSSHSupport = true;
  };

  # users
  users.mutableUsers = false;
  users.users.root.hashedPasswordFile = "${persistDir}/psk/root";
  users.users.jalen = {
    isNormalUser = true;
    home = "/home/jalen";
    extraGroups = [ "wheel" "networkmanager" ];
    hashedPasswordFile = "${persistDir}/psk/jalen";
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    sof-firmware
    gnomeExtensions.touchup
    gnomeExtensions.screen-rotate
    gnomeExtensions.easyeffects-preset-selector
  ];

  virtualisation.waydroid.enable = true;

  services.ollama = {
      enable = true;
      loadModels = [ "deepseek-r1:8b" "deepseek-r1:32b" ];
      acceleration = "rocm";
  };

  system.stateVersion = "25.05"; # Did you read the comment?
  nix.settings.experimental-features = "nix-command flakes";
}
