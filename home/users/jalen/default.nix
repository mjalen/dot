{ config, inputs, pkgs, ... }:

let
  uniqueScripts = (import ../../scripts) { inherit config pkgs; };
  nil-pkg = inputs.nil.packages.${pkgs.system}.nil;

  packages = with pkgs; [
    # my scripts
    uniqueScripts

    # misc
    pinentry-curses
    openssh
    brightnessctl
    acpi
    gimp
    libnotify
    mpc-cli
    ripgrep
    zathura
    imagemagick

    # pw manager
    pass
    gnupg

    # fonts
    victor-mono
    iosevka

  	# programming stuff
    emacs
    cargo
  	roswell # clisp implementation manager
    nil-pkg # nix lsp
    cmake
    gcc

    # screenshot double wammy ;)
    slurp
    grim

    # pulseaudio mixer.
    pamixer

    # vpn
    protonvpn-cli_2
    # protonvpn-gui

    # move to wayland/hyprland.nix
    hyprpaper

    (sbcl.withPackages (p: with p; [
        hunchentoot
        spinneret
        lass
        parenscript
    ]))

    # lsp-bridge deps for emacs
    (python3.withPackages (p: with p; [
        epc
        orjson
        sexpdata
        six
        setuptools
        paramiko
        rapidfuzz
        watchdog
        packaging
    ]))
  ];

  filterImports = (xs: builtins.filter (x: builtins.pathExists x) xs );

in

{
  # fuck these .. are ugly
  imports = filterImports [
    # Import theme (accessed via config.valhalla.theme)
    ../../../themes/oxocarbon/dark.nix

    # Window Management
    ../../wayland/hyprland
    ../../wayland/waybar.nix

    # Apps
    ../../applications/firefox
    ../../applications/kitty
    ../../applications/ncmpcpp.nix

    # Services
    ../../utilities/mako.nix
  ];

  home = {
    username = "jalen";
    homeDirectory = "/home/jalen";
    stateVersion = "23.11";
    inherit packages;
  };

  dconf.settings = {
    # add to home-manager
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  services = {
    emacs = {
      enable = true;
      defaultEditor = true;
    };
  };

#   home.file.".xinitrc.exwm" = {
#     text =
#       ''
# xhost +SI:localuser:$USER
# export _JAVA_AWT_WM_NONREPARENTING=1
# 
# xsetroot -cursor_name left_ptr
# xmodmap -e "keycode 66 = Control_L"
# 
# xset r rate 200 60
# 
# exec emacs
#      '';
#   };

  programs = {
    bash = {
      enable = true;
      profileExtra =
        ''
if [ -z "$DISPLAY" -a "$(tty)" = '/dev/tty5' ]; then
   exec Hyprland
fi
        '';
      bashrcExtra =
        ''
eval "$(ssh-agent -s)" && ssh-add ${config.home.homeDirectory}/.ssh/id_ed25519
        '';
    };
    git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      userName = "mjalen";
      userEmail = "ajalenboi@gmail.com"; # email me [ at your own peril >:) ]
      extraConfig = {
        color.ui = "always";
      };
    };
  };
}
