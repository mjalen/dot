{ lib, pkgs, ... }: {
    # configuration for ungoogled-chromium

    # home.packages = with pkgs; [ ungoogled-chromium ];

    programs.chromium = {
        enable = true;
        package = pkgs.ungoogled-chromium;
        extensions = [
            { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin

            { id = "dneaehbmnbhcippjikoajpoabadpodje"; } # old reddit redirect
        ];
    };

    xdg.configFile."chromium-flags.conf".text = ''
        --ozone-platform-hint=auto
        --ozone-platform=wayland
        --enable-features=TouchpadOverscrollHistoryNavigation
        --process-per-site
        --disable-sync-preferences
    '';
}