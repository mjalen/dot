{ config, inputs, pkgs, wallpaper, ... }:
let
  uniqueScripts = (import ./scripts) { inherit config pkgs; };
  nil-pkg = inputs.nil.packages.${pkgs.system}.nil;

  packages = with pkgs; [
    # my scripts
    uniqueScripts

    pciutils

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
    hwinfo
    hakuneko
    rclone
    trayscale

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
    jdk17
    raylib
    go

	  # Common Lisp
    (sbcl.withPackages (p: with p; [
      hunchentoot
      ningle
      spinneret
      lass
      parenscript
      swank
      swank-client
      local-time
      clack
      clack-handler-hunchentoot
    ]))

    swift

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
    proton-pass
    protonmail-desktop

	  helix
    upower
    scrcpy
    vlc
    strawberry
    youtube-music
    easyeffects
    kdePackages.dolphin
    wpaperd
    rustdesk
    labwc
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
    ./_old/applications/vscodium.nix
  ];

  home = {
    username = "jalen";
    homeDirectory = "/home/jalen";
    stateVersion = "23.11";
    inherit packages;

    sessionVariables = {
      MOZ_ENABLE_WAYLAND = 1;
      PRISMA_QUERY_ENGINE_LIBRARY = "${pkgs.prisma-engines}/lib/libquery_engine.node";
      PRISMA_QUERY_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/query-engine";
      PRISMA_SCHEMA_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/schema-engine";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Gruvbox-Dark";
      package = pkgs.gruvbox-gtk-theme;
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
    # addKeysToAgent = "yes";
  };

  programs.walker = {
    enable = true;
    runAsService = true;

    # All options from the config.toml can be used here.
    config = {
      placeholders."default".input = "Example";
      providers.prefixes = [
        {provider = "websearch"; prefix = "+";}
        {provider = "providerlist"; prefix = "_";}
      ];
      keybinds.quick_activate = ["F1" "F2" "F3"];
    };
  };

  services.kdeconnect = {
    enable = true;
    indicator = true;
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

  xdg.configFile = {
    "wpaperd/config.toml".text = ''
[default]
mode = "tile"
path = "${builtins.toString wallpaper}"
    '';

    "rclone/rclone.conf".text = ''
[macdav]
type = webdav
url = https://jalens-macbook-pro.bilberry-frog.ts.net
vendor = owncloud
pacer_min_sleep = 0.01ms
user = k
pass = Tnkxh76eXRPzL0aoqBGw-PNNJ8yqXjA
    '';
  };

  systemd.user.services.macdav-mount = {
    Unit = {
      Description = "Mount CopyParty WebDAV";
      After = [ "network-online.target" ];
    };
    Service = {
      Type = "notify";
      ExecStartPre = "/usr/bin/env mkdir -p %h/Remote";
      ExecStart = "${pkgs.rclone}/bin/rclone mount --vfs-cache-mode writes --dir-cache-time 5s macdav: ${config.home.homeDirectory}/Remote";
      ExecStop="/bin/fusermount -u ${config.home.homeDirectory}/Remote";
    };
    Install.WantedBy = [ "default.target" ];
  };
}
