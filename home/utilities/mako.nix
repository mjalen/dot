{ lib, pkgs, ... }: {

    # home.packages = with pkgs; [ mako ];

    services.mako = {
        enable = true;
        font = "Victor Mono 13";
        sort = "-time";
    };

}