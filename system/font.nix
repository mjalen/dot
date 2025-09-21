{ pkgs, ... }: {
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      font-awesome
      source-code-pro
      source-sans-pro
      source-serif-pro
    ];
    fontconfig = {
      antialias = true;
      cache32Bit = true;
      hinting.enable = true;
      hinting.autohint = true;
      defaultFonts = {
        monospace = [ "Monaspace" ];
        sansSerif = [ "Monaspace" ];
        serif = [ "Source Serif Pro" ];
      };
    };
  };
}
