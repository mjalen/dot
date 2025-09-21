{ pkgs, lib, ... }:


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

  networking.hostName = "robin"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  networking.firewall = {
    enable = true;
    trustedInterfaces = lib.mkForce [ "tailscale0" ];
    #     allowedTCPPorts = [ 5000 ];
    #     allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    #     allowedUDPPortRanges = allowedTCPPortRanges;
  };

  services.openssh.openFirewall = false;

  systemd.services.tailscale-wait-for-routes = {
    requires = [ "network.target" "tailscaled.service" ];
    after = [ "network.target" "tailscaled.service" ];
    wantedBy = [ "multi-user.target" ];
    script = ''
      until ip route get 8.8.8.8 >/dev/null 2>&1; do sleep 1; done
    '';
  };

  # Set your time zone.
  time.timeZone = "America/Chicago";

  programs.adb.enable = true;
  programs.coolercontrol.enable = true;

#   services.xserver.windowManager.dwm.enable = true;
#   services.xserver.windowManager.dwm.package = pkgs.dwm.override {
#     patches = [
#       (pkgs.fetchPatch {
#         url = "https://dwm.suckless.org/patches/bar_height/dwm-bar-height-6.2.diff";
#         hash = "";
#       })
#     ];
#   };

#   services.xserver.enable = true;
#   services.xserver.displayManager.startx = {
#     extraCommands = ''
# exec dwm
#     '';
#   };

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

  # Finances
  services.actual = {
    enable = true;
    openFirewall = true;
  };

  # users
  users.mutableUsers = false;
  users.users.root.hashedPasswordFile = "${persistDir}/psk/root";
  users.users.jalen = {
    isNormalUser = true;
    home = "/home/jalen";
    extraGroups = [ "wheel" "networkmanager" "adbusers" ];
    hashedPasswordFile = "${persistDir}/psk/jalen";
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    sof-firmware
    gnomeExtensions.easyeffects-preset-selector
    tailscale
    xorg.xorgserver
    xorg.xinit
    xorg.xf86inputevdev
    xorg.xf86inputsynaptics
    xorg.xf86inputlibinput
    xorg.xf86videointel
    xorg.xf86videoati
  ];

  virtualisation.waydroid.enable = true;

  programs.honkers-launcher.enable = true;
  programs.honkers-railway-launcher.enable = true;

  services.blueman.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
    openFirewall = true;
  };

  services.ollama = {
    enable = true;
    loadModels = [ "deepseek-r1:8b" "deepseek-r1:32b" ];
    acceleration = "rocm";
  };

  system.stateVersion = "25.05"; # Did you read the comment?
  nix.settings.experimental-features = "nix-command flakes";

  nix.settings = {
    substituters = [ "https://ezkea.cachix.org" ];
    trusted-public-keys = [
      "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
    ];
  };
}
