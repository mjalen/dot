{ pkgs, lib, ... }: {
    home.username = "jalen";
    home.homeDirectory = "/home/jalen";

    programs.git.enable = lib.mkDefault true;
    programs.git.userName = lib.mkDefault "mjalen";
    programs.git.userEmail = "ajalenboi@gmail.com";

    home.packages = with pkgs; [
        ranger
    ];

    programs.neovim.enable = lib.mkDefault true;
    programs.neovim.vimAlias = lib.mkDefault true;

    home.stateVersion = "23.05";
}