{ lib, pkgs, ...}: 

let
	packages = with pkgs; [
		ranger
		neofetch
		pinentry
		pinentry-curses
		openssh
		kitty
		firefox
		brightnessctl
		acpi
		ungoogled-chromium
	];
in
{
    imports = [
	../wm/hyprland.nix
	../mod/gpg.nix
    ];

    home = {
	username = "jalen";
   	homeDirectory = "/home/jalen";
	stateVersion = "23.11";
	inherit packages;
    };

    programs = {
	home-manager.enable = true;
	git = {
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
	neovim = {
       		enable = true;
        	vimAlias = true;
    	};
    };

    /*home.persistence."/nix/persist/home/jalen" = {
	allowOther = true; # required. relies on host/motherbase.nix#programs.fuse.userAllowOthers
	directories = [
		"Documents"	
		".ssh"
	];
    };*/

}
