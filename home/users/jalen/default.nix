{ inputs, pkgs, ...}: 

let
    current-theme = (import ../../../themes/oxocarbon).dark;
	packages = with pkgs; [
		ranger
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

		victor-mono
		font-awesome

		pamixer

		hyprpaper

	];

    withTheme = module: ((import module) current-theme);
in
{
    imports = [
		# GUI 
		../../wayland/hyprland.nix
		# ((import ../../wayland/waybar.nix) current-theme)
		(withTheme ../../wayland/waybar.nix)
		# ../wayland/anyrun.nix

		# Apps
		../../applications/vscodium.nix
		../../applications/firefox.nix 
		../../applications/tmux.nix
		../../applications/nvim
		(withTheme ../../applications/kitty.nix) 

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
				"get-audio" = "pamixer --get-volume-human";
				"build-home" = "nix build .#homeConfigurations.jalen.activationPackage && result/activate"; # convenience for a common cmd string.
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
