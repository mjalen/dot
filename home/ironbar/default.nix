{ pkgs, ... }: {
  home.packages = with pkgs; [ ironbar ];
  xdg.configFile."ironbar/config.yaml".source = ./config.yaml;
}
