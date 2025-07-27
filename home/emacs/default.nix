{ config, pkgs, ... }:
let
  /*
    WARNING I like hacking my Emacs config independently of Nix. But,
    I also home-manager to track Emacs. So, an "out-of-store" symlink
    is made from the absolute path of my Emacs config to the XDG
    configuration. This is not recommended, so be warned of the risk
    I am taking. Your path to this config will most likely be different
    than mine.
  */
  emacs-path = /home/jalen/Documents/dot/home/emacs/init.el;
in
{
  services.emacs = {
    enable = true;
    defaultEditor = true;
  };

  home.packages = with pkgs; [ emacs ];

  xdg.configFile."emacs/init.el".source = config.lib.file.mkOutOfStoreSymlink emacs-path;
}
