{ config, inputs, pkgs, ... }:
let
  uniqueScripts = (import ./scripts) { inherit config pkgs; };
  nil-pkg = inputs.nil.packages.${pkgs.system}.nil;

  packages = with pkgs; [
    # my scripts
    uniqueScripts

    # misc
    openssl
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
    weston
    yacreader
    swww
    ghostty
    alsa-utils

    # gnome
    gnome-tweaks
    bibata-cursors
    rot8
    komikku

    # fonts
    victor-mono
    font-awesome

    # programming stuff
    cargo
    nil-pkg # nix lsp
    cmake
    gcc
    nodejs_24
    sqlite

	  # Common Lisp
    (sbcl.withPackages (p: with p; [
        hunchentoot
        spinneret
        lass
        parenscript
        swank
        swank-client
    ]))

    # node packages
    prisma
    prisma-engines
    typescript-language-server
    typescript

    # screenshot double wammy ;)
    slurp
    grim

    # pulseaudio mixer.
    pamixer

    # Proton
    protonvpn-cli_2
    protonvpn-gui
    proton-pass

	  helix
    wdisplays

    upower

  ];

  filterImports = (xs: builtins.filter (x: builtins.pathExists x) xs );

in
{
  imports = filterImports [
    ../themes/oxocarbon/dark.nix
    ./firefox
    ./kitty
    ./waybar
    ./niri
    ./emacs
  ];

  home = {
    username = "jalen";
    homeDirectory = "/home/jalen";
    stateVersion = "23.11";
    inherit packages;

    sessionVariables = {
      USER_JALEN_IS_ACTIVATED = 1;
      PRISMA_QUERY_ENGINE_LIBRARY = "${pkgs.prisma-engines}/lib/libquery_engine.node";
      PRISMA_QUERY_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/query-engine";
      PRISMA_SCHEMA_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/schema-engine";
    };
  };

  dconf.settings = {
    # add to home-manager
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  xdg.enable = true;

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };

  programs.fuzzel = {
    enable = true;
    settings = {
      colors = {
        background = "161616ff";
        text = "ffffffff";
        match = "ee5396ff";
        selection-match = "ee5396ff";
        selection = "262626ff";
        selection-text = "33b1ffff";
        border = "525252ff";
      };
    };
  };

  programs = {
    bash = {
      enable = true;
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
