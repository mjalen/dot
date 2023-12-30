{ lib, pkgs, ... }: {
    # configuration for ungoogled-chromium

    home.packages = with pkgs; [ ungoogled-chromium ];

    xdg.configFile."chromium-flags.conf".text = ''
        --ozone-platform-hint=auto
        --ozone-platform=wayland
        --enable-features=TouchpadOverscrollHistoryNavigation
        --process-per-site
        --disable-sync-preferences
    '';
}