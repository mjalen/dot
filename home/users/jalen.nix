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
		# ungoogled-chromium
		victor-mono

		hyprpaper

	];
in
{
    imports = [
	../wm/hyprland.nix
	../applications/vscodium.nix
	../applications/chromium.nix
    ];

    home = {
		username = "jalen";
 	  	homeDirectory = "/home/jalen";
		stateVersion = "23.11";
		inherit packages;
    };

    programs = {
		git = {
			enable = true;
			package = pkgs.gitAndTools.gitFull;
				userName = "mjalen"; 
				userEmail = "ajalenboi@gmail.com"; # email me [ at your own peril >:) ]
			extraConfig = {
				color.ui = "always";
			};
		};
		neovim = {
				enable = true;
				vimAlias = true;
		};
	};
}
