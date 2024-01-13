{ config, lib, pkgs, ...}: 

with lib;
let
	cfg = config.valhalla.users.jalen;
in
{
	# fuck these .. are ugly
    imports = [
		# Import theme (accessed via config.valhalla.theme)
		../../themes/oxocarbon/dark.nix

		# Wayland 
		../../wayland

		# Apps
		../../applications/ranger.nix
		../../applications/firefox 
		../../applications/tmux.nix
		../../applications/nvim
		../../applications/emacs
		../../applications/kitty
		../../applications/ncmpcpp.nix

		# Other
		../../utilities/tex.nix
		../../utilities/mako.nix # notification daemon
    ];

	options.valhalla.users.jalen = {
		enable = mkOption { type = types.bool; };
	};

	# messy, find a way to import with config, pkgs, etc.
	config = mkIf cfg.enable (
		let
			packages = with pkgs; [
				# misc
				gobble			neofetch
				pinentry		pinentry-curses
				openssh			brightnessctl
				acpi			gimp
				libnotify		mpc-cli
				ripgrep

				# spotify 
				spotify

				# math stuff
				# mathematica # /nix/store/d692a31x9p74vxrnwdlqh5k5a7m4kqkd-Mathematica_13.3.1_BNDL_LINUX.sh
				# I think I need a new bndl script for mathematica

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
				youtube-tui

				# move to wayland/hyprland.nix
				hyprpaper
			];
		in {
			home = {
				username = "jalen";
				homeDirectory = "/home/jalen";
				stateVersion = "23.11";
				inherit packages;
			};

			valhalla.wayland = { # custom defined config from wayland default
				enable = true;
				bar = "waybar";
				windowManager = "hyprland";
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
					shellAliases = {
						"build-home" = let
							hm = config.home.homeDirectory;
						in "nix build ${hm}/Documents/dot#homeConfigurations.x86_64-linux.jalen.activationPackage && ${hm}/Documents/dot/result/activate"; # convenience for a common cmd string.

						# currently this script has a bug for albums/artsists with '/' in their name.
						"mpd-art-path" = let
							md = config.services.mpd.musicDirectory;	
						in ''cover="${md}/$(mpc current -f '%artist% - %album%')/cover"; \
							coverPNG="$(echo $cover).png"; \
							coverJPG="$(echo $cover).jpg"; \
							if [[ -e $coverPNG ]]; then \
								echo $coverPNG; \
							else \
								echo $coverJPG; \
							fi
						'';

						"notify-mpd" = ''
							while "true"; do
								notify-send `Now Playing` "$(mpc current --wait -f '%artist%\n%title%')" -i "$(mpd-art-path)" -t 3000
								cp "$(mpd-art-path)" /tmp/mpd_art
							done
						'';
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
	);
}
