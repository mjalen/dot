{ lib, pkgs, ... }: {

    # home.packages = with pkgs; [ mako ];

    services.mako = {
        enable = true;
        font = "Victor Mono 10";
        sort = "-time";
    };

}