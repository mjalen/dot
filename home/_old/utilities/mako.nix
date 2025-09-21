{ config, ... }:

with config.valhalla.theme;
{

  services.mako = {
    enable = true;
    settings = {
      font = "Victor Mono 13";
      sort = "-time";
      textColor = base05;
      backgroundColor = base00;
      maxIconSize = 64;
    };
  };

}
