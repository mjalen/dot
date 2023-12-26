{ pkgs, lib, ... }: {
    home.username = "jalen";
    home.homeDirectory = "/home/jalen";

    programs.git = {
        enable = true;
        userName = mjalen; 
        userEmail = "ajalenboi@gmail.com"; # email me [ at your own peril >:) ]
    };

    home.packages = with pkgs; head [
        ranger
    ];

    programs.neovim = {
        enable = lib.mkDefault true;
        vimAlias = lib.mkDefault true;
    };

    home.stateVersion = "23.05";
}