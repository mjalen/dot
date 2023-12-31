{ lib, pkgs, ...}: 

let
	packages = with pkgs; [
		ranger
		neofetch
		pinentry
		pinentry-curses
		openssh
		kitty
		brightnessctl
		acpi

		victor-mono
		font-awesome

		pamixer

		hyprpaper

	];
in
{
    imports = [
		# GUI 
		../wm/hyprland.nix
		../wm/waybar.nix

		# Apps
		../applications/vscodium.nix
		../applications/firefox.nix 

		# Other
		../utilities/mako.nix # notification daemon
    ];

    home = {
		username = "jalen";
 	  	homeDirectory = "/home/jalen";
		stateVersion = "23.11";
		inherit packages;
    };

    programs = {
		bash = {
			enable = true;
			shellAliases = {
				"get-audio" = "pamixer --get-volume-human";
				"build-home" = "nix build .#homeConfigurations.jalen.activationPackage && result/activate"; # convenience for a common cmd string.
			};
		};
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
