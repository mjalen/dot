{ config, inputs, pkgs, ...}: 

let
	uniqueScripts = (import ../../scripts) { inherit config pkgs; };

	packages = with pkgs; [
		# my scripts
		uniqueScripts

		# misc
		# gobble
		neofetch
		pinentry
		pinentry-curses
		openssh
		brightnessctl
		acpi
		gimp
		libnotify
		mpc-cli
		ripgrep

		# spotify 
		# spotify

		# math stuff
		# mathematica # /nix/store/d692a31x9p74vxrnwdlqh5k5a7m4kqkd-Mathematica_13.3.1_BNDL_LINUX.sh

		# screenshot double wammy ;)
		slurp
		grim

		# botware
		zoom-us

		# TODO add fonts to fonts.fonts
		victor-mono
		font-awesome

		# pulseaudio mixer.
		pamixer

		# youtube
		# youtube-tui

		# move to wayland/hyprland.nix
		hyprpaper
	];

in

{
	# fuck these .. are ugly
    imports = [
		# Import theme (accessed via config.valhalla.theme)
		../../../themes/oxocarbon/dark.nix

		# GUI 
		../../wayland/hyprland
		../../wayland/waybar.nix

		# Apps
		../../applications/ranger.nix
		../../applications/firefox 
		../../applications/tmux.nix
		../../applications/kitty
		../../applications/ncmpcpp.nix

		# Editors
		../../applications/nvim

		# Other
		# ../../utilities/mpd.nix
		# ../../utilities/tex.nix
		../../utilities/mako.nix # notification daemon
    ];

    home = {
		username = "jalen";
 	  	homeDirectory = "/home/jalen";
		stateVersion = "23.11";
		inherit packages;
    };

	dconf.settings = { # add to home-manager
		"org/virt-manager/virt-manager/connections" = {
			autoconnect = [ "qemu:///system" ];
			uris = [ "qemu:///system" ];
		};
	};


    programs = {
		bash = {
			enable = true;
			/*bashrcExtra = ''

			'';*/
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
	};
}

