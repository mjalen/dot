{ config, lib, pkgs, ... }:

with config.valhalla.theme;
{

  # home.packages = with pkgs; [  ];

  services.mako = {
    enable = true;
    font = "Victor Mono 13";
    sort = "-time";
    textColor = base05;
    backgroundColor = base00;
    maxIconSize = 64;
  };

}
