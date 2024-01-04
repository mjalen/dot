{ config, inputs, pkgs, ...}: 

let
	packages = with pkgs; [
		gobble
		neofetch
		pinentry
		pinentry-curses
		openssh
		brightnessctl
		acpi
		gimp

		# screenshot double wammy ;)
		slurp
		grim

		# TODO add fonts to fonts.fonts
		victor-mono
		font-awesome

		# pulseaudio mixer.
		pamixer

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
		../../wayland/hyprland.nix
		../../wayland/waybar.nix

		# Apps
		../../applications/ranger.nix
		../../applications/vscodium.nix
		../../applications/firefox 
		../../applications/tmux.nix
		../../applications/nvim
		../../applications/kitty.nix

		# Other
		../../utilities/mako.nix # notification daemon
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
				"build-home" = "nix build ~/Documents/dot#homeConfigurations.jalen.activationPackage && ~/Documents/dot/result/activate"; # convenience for a common cmd string.
			};
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

