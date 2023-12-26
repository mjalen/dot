{ pkgs, lib, ... }: {
    home.username = "jalen";
    home.homeDirectory = "/home/jalen";

    home.packages = with pkgs; [
        ranger
        neofetch
    ];

    programs.git = {
        enable = true;
        userName = mjalen; 
        userEmail = "ajalenboi@gmail.com"; # email me [ at your own peril >:) ]
    };

    programs.neovim = {
        enable = lib.mkDefault true;
        vimAlias = lib.mkDefault true;
    };

    home.stateVersion = "23.05";
}