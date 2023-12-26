{ pkgs, lib, ... }: {
    home.username = "jalen";
    home.homeDirectory = "/home/jalen";

    home.packages = with pkgs; [
        ranger
        neofetch
	pinentry
	pinentry-curses
	openssh
    ];

    programs.git = {
        enable = true;
	package = pkgs.gitAndTools.gitFull;
        userName = "mjalen"; 
        userEmail = "ajalenboi@gmail.com"; # email me [ at your own peril >:) ]
	/*signing = {
		key = "B5BAE6761C9A6394";
		signByDefault = true;
	};*/
	extraConfig = {
		color.ui = "always";
	};
    };

    programs.neovim = {
        enable = true;
        vimAlias = true;
    };

    home.stateVersion = "23.05";
}
