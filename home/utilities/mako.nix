{ lib, pkgs, ... }: {

    # home.packages = with pkgs; [  ];

    services.mako = {
        enable = true;
        font = "Victor Mono 13";
        sort = "-time";
    };

}
