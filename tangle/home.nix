

# The same must /also/ be defined for our home-manager configuration. Below is our ~home.nix~ file.


# [[file:../Config.org::*NixOS and Home Manager][NixOS and Home Manager:2]]
{ config, inputs, pkgs, lib, ... }:
let
  concatAttr = list: builtins.foldl' (a: b: a // b) {} list;
in

concatAttr [
# NixOS and Home Manager:2 ends here

# Jalen


# [[file:../Config.org::*Jalen][Jalen:1]]
(
  let
	  username = "jalen";
	  # uniqueScripts = (import ./scripts) { inherit config pkgs; };

	  packages = with pkgs; [
		  # my scripts
		  # uniqueScripts

		  # misc
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
		  discord
		  glow
		  zathura
      imagemagick

		  # math stuff
      # I need a new bndl file.
		  # mathematica # /nix/store/d692a31x9p74vxrnwdlqh5k5a7m4kqkd-Mathematica_13.3.1_BNDL_LINUX.sh

		  # notes and markup
		  logseq
		  zotero

		  # screenshot double wammy ;)
		  slurp
		  grim

		  # botware
      spotify
		  zoom-us

		  # TODO add fonts to fonts.fonts
		  victor-mono
		  font-awesome

		  # pulseaudio mixer.
		  pamixer
	  ];

  in

    {
      imports = [
		    ../themes/oxocarbon/dark.nix # I have not ported this to org-mode yet.
      ];

      home = {
        inherit username;
        inherit packages;
        homeDirectory = "/home/${username}";
        stateVersion = "23.11";
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
			    bashrcExtra = ''
        #    if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
        #    exec tmux attach
        #    fi
			'';
		    };
		    ssh.enable = true;
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
)
# Jalen:1 ends here

# TODO Emacs 

# - [ ] Fix paths with a more sane file structure given the new org-mode configuration.

# Truly a long configuration just to act as a bootloader ;). For now I am symlinking directly from this directory to ~~/.emacs.d~ because I want to be able to edit my configuration naturally like in other systems. I would love to find a way to do this through the nix store, but for now it is what it is. Emacs and Nix are at odds with each other configuration-wise (at least I believe). 


# [[file:../Config.org::*Emacs][Emacs:1]]
(
  let
	  hm = config.home.homeDirectory;
  in
    {
	    services.emacs = {
		    enable = true;
		    defaultEditor = true;
		    package = pkgs.emacs29-pgtk;
	    };

	    programs.emacs = {
		    enable = true;
		    package = pkgs.emacs29-pgtk;
	    };

      home.packages = with pkgs; [ cmake texliveFull ]; # may be good to add this to user instead perhaps?

	    systemd.user.tmpfiles.rules = [
		    # "d ${hm}/.emacs.d 0755 jalen users - -" # Create emacs directory.
		    # link config files.
		    "L+ ${hm}/.emacs.d/config.org - - - - ${hm}/Documents/dot/xdg/emacs.d/config.org"
		    "L+ ${hm}/.emacs.d/init.el - - - - ${hm}/Documents/dot/xdg/emacs/emacs.d/init.el"
	    ];
    }
)
# Emacs:1 ends here

# Default


# [[file:../Config.org::*Default][Default:1]]
{
  # firefox stuffs
  programs.firefox = with config.valhalla.theme; {
    enable = true;
    profiles = {
      default = {
        isDefault = true;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          sponsorblock
          old-reddit-redirect
		      darkreader
        ];
        settings = {
          "identity.fxaccounts.enabled" = false;
          "extensions.pocket.enabled" = false;
          "extensions.autoDisableScopes" = 0;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
					"extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
          "extensions.getAddons.cache.enabled" = false;
					"media.rdd-ffmpeg.enabled" = true;
					"media.ffmpeg.vaapi.enabled" = true;
					"media.navigator.mediadatadecoder_vpx_enabled" = true;
					"gfx.webrender.all" = true;

					"browser.startup.blankWindow" = true;
					"browser.sessionstore.resume_session_once" = true;

					# Why would I want this?
					"toolkit.telemetry.archive.enabled" = false;
					"toolkit.telemetry.enabled" = false;
					"toolkit.telemetry.rejected" = true;
					"toolkit.telemetry.server" = "<clear value>";
					"toolkit.telemetry.unified" = false;
					"toolkit.telemetry.unifiedIsOptIn" = false;
        };
        userChrome = builtins.readFile ./../xdg/firefox/userChrome.css;
      };
    };
  };
}
# Default:1 ends here

# Kitty

# The terminal emulator of choice.


# [[file:../Config.org::*Kitty][Kitty:1]]
{
  programs.kitty = {
    enable = true;
    settings = with config.valhalla.theme; {
      enable_audio_bell = false;
      window_margin_width = 10;
      cursor_shape = "block";

			font_size = 12;
			font_family = "Victor Mono";
			bold_font = "auto";
			italic_font = "auto";
		  bold_italic_font = "auto"; 

		  background_opacity = "0.95";
      background_blur = 10;

			confirm_os_window_close = 0;

      # color map 

			# Base16 {{scheme-name}} - kitty color config
			# Scheme by {{scheme-author}}
			background = base00; #{{base00-hex}}
			foreground = base05; #{{base05-hex}}
			selection_background = base05; #{{base05-hex}}
			selection_foreground = base00; #{{base00-hex}}
			url_color = base04; #{{base04-hex}}
			cursor = base05; #{{base05-hex}}
			active_border_color = base03; #{{base03-hex}}
			inactive_border_color = base01; #{{base01-hex}}
			active_tab_background = base00; #{{base00-hex}}
			active_tab_foreground = base05; #{{base05-hex}}
			inactive_tab_background = base01; #{{base01-hex}}
			inactive_tab_foreground = base04; #{{base04-hex}}
			tab_bar_background = base01; #{{base01-hex}}

			# normal
			color0 = base00; #{{base00-hex}}
			color1 = base08; #{{base08-hex}}
			color2 = base0B; #{{base0B-hex}}
			color3 = base0A; #{{base0A-hex}}
			color4 = base0D; #{{base0D-hex}}
			color5 = base0E; #{{base0E-hex}}
			color6 = base0C; #{{base0C-hex}}
			color7 = base05; #{{base05-hex}}

			# bright
			color8 = base03; #{{base03-hex}}
			color9 = base09; #{{base09-hex}}
			color10 = base01; #{{base01-hex}}
			color11 = base02; #{{base02-hex}}
			color12 = base04; #{{base04-hex}}
			color13 = base06; #{{base06-hex}}
			color14 = base0F; #{{base0F-hex}}
			color15 = base07;
    };
  }; 
}
# Kitty:1 ends here

# TODO Neovim

# Terminal editor, when Emacs fails. _It never fails!_


# [[file:../Config.org::*Neovim][Neovim:1]]
(
  let
	  hm = config.home.homeDirectory;

	  # copy nvim configuration to store.
	  nvim-config = pkgs.stdenv.mkDerivation {
		  name = "nvim config";
		  src = "../xdg/nvim"; 
		  buildInputs = with pkgs; [ coreutils ];
		  
		  buildPhase = "";
		  
		  installPhase = ''
			mkdir -p $out
			cp -r * $out/.
		'';
	  };
  in
    {
	    # This symlink is required for my fnl config to work 
	    # I am symlinking my xdg config to the copied config files.
	    systemd.user.tmpfiles.rules = [
		    "L+ ${hm}/.config/nvim/ - - - - ${nvim-config}"
	    ];

	    # change editor
	    programs.bash.bashrcExtra = ''
		export EDITOR=vim
	'';

	    programs.neovim = {
		    enable = true;
		    viAlias = true;
		    vimAlias = true;

		    # my neovim config is done nearly exclusively in Fennel
		    # so there is a simple lua script to use as a gateway.

		    plugins = 
			    with pkgs.vimPlugins; 
			    with nvim-treesitter-parsers; 
			    # with pkgs.nur.repos.m15a.vimExtraPlugins; # Having problems with deprecation here. 
		      [
			      # for fennel
			      hotpot-nvim

			      # line
			      lualine-nvim
			      indent-blankline-nvim
			      # incline-nvim
			      
			      # language server
			      nvim-lspconfig
			      cmp-nvim-lsp
			      cmp-buffer
			      nvim-cmp

			      # TODO LaTeX
			      vimtex
			      nabla-nvim

			      # tmux 
			      (lib.mkIf config.programs.tmux.enable vim-tmux-navigator)

			      # telescope
			      plenary-nvim
			      telescope-nvim
			      telescope-file-browser-nvim

			      # toggle term
			      toggleterm-nvim

			      # theme
			      oxocarbon-nvim

			      # git
			      gitsigns-nvim
			      diffview-nvim

			      # TODO lisp
			      # add Olical/aniseed and conjure

			      # glow
			      glow-nvim

			      # tree sitter
			      nvim-treesitter
			      cmp-treesitter
			      c
			      cpp
			      vue
			      javascript
			      html
			      css
			      vim
			      lua
			      fennel
			      glsl
			      diff
			      commonlisp
			      latex
			      typescript
			      markdown
			      markdown_inline
			      nix
			      rust

			      # other	
			      nvim-web-devicons
		      ];
	    };
    }
)
# Neovim:1 ends here

# Ranger


# [[file:../Config.org::*Ranger][Ranger:1]]
{
	home.packages = with pkgs; [ ranger ];

	xdg.configFile."ranger/rc.conf".text = ''
		set preview_images true
		set preview_images_method kitty
	'';

	programs.bash.bashrcExtra = ''
		export VISUAL=vim
		export PAGER=more
	'';
}
# Ranger:1 ends here

# Terminal Multiplexer


# [[file:../Config.org::*Terminal Multiplexer][Terminal Multiplexer:1]]
{
	programs.tmux = {
		enable = true;
		keyMode = "vi";
		shortcut = "a";
		mouse = true;
		baseIndex = 1;

		extraConfig = ''
			new-session -n $HOST
			bind r source-file ~/.config/tmux/tmux.conf

			# statusbar
			set -g status-position bottom
			set -g status-justify left
			set -g status-style 'fg=color2'
			set -g status-left ' ' 
			set -g status-right '%Y-%m-%d %H:%M '
			set -g status-right-length 50
			set -g status-left-length 10

			setw -g window-status-current-style 'fg=color0 bg=color1 bold'
			setw -g window-status-current-format ' #I #W #F '

			setw -g window-status-style 'fg=colour2 dim'
			setw -g window-status-format ' #I #[fg=color7]#W #[fg=color2]#F '

			setw -g window-status-bell-style 'fg=color2 bg=color1 bold'
		'';
	};
}
# Terminal Multiplexer:1 ends here

# Scripts


# [[file:../Config.org::*Scripts][Scripts:1]]
(
  let
	  build-home = 
		  let
			  hm = config.home.homeDirectory;
		  in pkgs.writeShellScriptBin "build-home" ''
			nix build ${hm}/Documents/dot#homeConfigurations.jalen.activationPackage && \
			${hm}/Documents/dot/result/activate
		'';

	  mpd-art-path =
		  let
			  md = config.services.mpd.musicDirectory;	
		  in pkgs.writeShellScriptBin "mpd-art-path" ''
			cover="${md}/$(mpc current -f '%artist% - %album%')/cover"
			coverPNG="$(echo $cover).png"
			coverJPG="$(echo $cover).jpg"
			if [[ -e $coverPNG ]]; then
				echo $coverPNG
			else
				echo $coverJPG
			fi
		'';

	  notify-mpd = pkgs.writeShellScriptBin "notify-mpd" ''
		while "true"; do
			notify-send `Now Playing` "$(mpc current --wait -f '%artist%\n%title%')" \
				-i "$(mpd-art-path)" -t 3000
			cp "$(mpd-art-path)" /tmp/mpd_art
		done
	'';

  in {
    home.packages = [
      pkgs.symlinkJoin { # custom package containing scripts.
	      name = "scripts";
	      paths = [
		      build-home
		      mpd-art-path
		      notify-mpd
	      ];
      }
    ];
  }
)
# Scripts:1 ends here

# Mako

# Notification daemon.


# [[file:../Config.org::*Mako][Mako:1]]
{
  services.mako = with config.valhalla.theme; {
    enable = true;
    font = "Victor Mono 13";
    sort = "-time";
		textColor = base05;
		backgroundColor = base00;
		maxIconSize = 64;
  };
}
# Mako:1 ends here

# MPD


# [[file:../Config.org::*MPD][MPD:1]]
(
  let
	  hm = config.home.homeDirectory;
  in {
	  services.mpd = {
		  enable = true;
		  network.startWhenNeeded = true;
		  musicDirectory = "${hm}/Music"; # replace with proper non-hardcoded path
	  };

	  # create database file.
	  systemd.user.tmpfiles.rules = [
		  "f ${hm}/.config/mpd/database 0755 jalen users - -"
	  ];

	  # I could not get mpd to generate this conf without writing it manually.
	  xdg.configFile."mpd/mpd.conf".text = ''
		port "6600"
		db_file "${hm}/.config/mpd/database"
		music_directory "${hm}/Music"

		audio_output {
			type "pulse"
			name "pulse audio"
		}

		audio_output {
			type                    "fifo"
			name                    "my_fifo"
			path                    "/tmp/mpd.fifo"
			format                  "44100:16:2"
		}
	'';

  }
)
# MPD:1 ends here

# TODO TexLive

# - [ ] Probably should move this elsewhere....


# [[file:../Config.org::*TexLive][TexLive:1]]
{
	home.packages = with pkgs; [ texliveFull ];
}
# TexLive:1 ends here

# Hyprland



# [[file:../Config.org::*Hyprland][Hyprland:1]]
(
  let
	  hm = config.home.homeDirectory;
	  wallpaper = "${hm}/Pictures/nier-arch.jpg";

    workspace-binds = (
	    builtins.concatLists (builtins.genList (
		    x: let 
			    ws = let
				    c = (x+1) / 10;
			    in
				    builtins.toString (x + 1 - (c * 10));
		    in [
			    "$mod, ${ws}, workspace, ${toString (x+1)}"
			    "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x+1)}"
		    ]
	    ) 10)
    );
  in {
	  systemd.user.tmpfiles.rules = [ # required for hyprland to open properly.
		  "d /tmp/hypr 0755 jalen users - -"
	  ];

	  home.packages = with pkgs; [ hyprpaper ];

	  wayland.windowManager.hyprland = {
		  enable = true;
		  settings = {
			  monitor = "eDP-1,2256x1504@60,0x0,1";

			  general = {
				  border_size = 3;
			  };

			  decoration = {
				  rounding = 7;
			  };

			  exec-once = [
				  "hyprpaper"
				  #config.programs.bash.shellAliases."notify-mpd"
				  #"notify-mpd" # custom alias that listens to mpd and notifies with new songs.
				  "waybar"
			  ];

			  # Window swallowing... which half works.
			  # It depends on the program. Image viewers like feh seem to swallow. 
			  misc = {
				  enable_swallow = true;
				  swallow_regex = "^(kitty)$";
				  disable_hyprland_logo = true; # sorry hypr-chan :(
			  };

			  animation = [
				  "windows, 1, 1, default, popin"
			  ];

			  # remap capslock to ctrl
			  input.kb_options = "ctrl:nocaps";

			  "$mod" = "SUPER";

			  # mouse bindings 
			  bindm = [
				  "$mod, mouse:272, movewindow"
				  "$mod Shift, mouse:272, resizewindow"
			  ];

			  # key bindings
			  bind = [
				  # Applications
				  "$mod Shift, F, exec, firefox"
				  "$mod, Return, exec, kitty"
				  "$mod, E, exec, emacsclient -c"

          # because not all my changes update the server even on eval.
          "$mod Shift, E, exec, systemctl --user restart emacs.service" 

				  # Move window
				  "$mod, H, exec, hyprctl dispatch movewindow l"
				  "$mod, J, exec, hyprctl dispatch movewindow d"
				  "$mod, K, exec, hyprctl dispatch movewindow u"
				  "$mod, L, exec, hyprctl dispatch movewindow r"

				  # Actions 
				  "$mod, Q, exec, hyprctl dispatch killactive"
				  "$mod, F, exec, hyprctl dispatch togglefloating"
				  "$mod, Tab, cyclenext"
				  "$mod, Tab, bringactivetotop"
				  "$mod Shift, Escape, exec, hyprctl dispatch exit"

				  # Screenshots
				  ", Print, exec, slurp | grim -g - ${hm}/Pictures/Screenshots/$(date +%Y%m%d_%H%M)_screenshot.png"
				  "$mod, Print, exec, grim ${hm}/Pictures/Screenshots/$(date +%Y%m%d_%H%M)_screenshot.png"

				  # Brightness
				  ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
				  ", XF86MonBrightnessUp, exec, brightnessctl set 10%+"

				  # Audio
				  ", XF86AudioRaiseVolume, exec, pactl -- set-sink-volume 0 +10%"
				  ", XF86AudioLowerVolume, exec, pactl -- set-sink-volume 0 -10%"
				  ", XF86AudioMute, exec, pactl -- set-sink-mute 0 toggle"
			  ] ++ workspace-binds;
		  };
	  };

	  xdg.configFile."hypr/hyprpaper.conf".text = ''
		preload = ${wallpaper} 
		wallpaper = eDP-1,${wallpaper}
	'';
  }
)
# Hyprland:1 ends here

# Waybar


# [[file:../Config.org::*Waybar][Waybar:1]]
{
  programs.waybar = with config.valhalla.theme; {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        output = [ "eDP-1" ];

        "hyprland/workspaces" = {
          "format" = "<sub>{icon}</sub>";
          "on-scroll-up" = "hyprctl dispatch workspace e+1";
          "on-scroll-down" = "hyprctl dispatch workspace e-1";
        };

				"hyprland/window" = {
					"format" = "{title}";
					"rewrite" = {
						"(.*) — Mozilla Firefox" = "&#xf269; $1";
						"(.*) - Spotify" = "&#xf1bc; $1";
						"(.*) - bash" = "&#xf120 [$1]";
						# "(.*) - ";
					};
					"separate-outputs" = true;
				};

        "clock" = {
          "interval" = 60;
          "format" = "{:%H:%M}";
          "max-length" = 25;
        };

        "battery" = {
          "states" = {
            "good" = 95;
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{capacity}% {icon}";
          "format-charging" = "{capacity}% ";
          "format-plugged" = "{capacity}% ";
          "format-alt" = "{time} {icon}";
          "format-icons" = ["" "" "" "" ""];
        };

        "network" = {
          "format-wifi" = "";
          "format-ethernet" = "";
          "tooltip-format" = " {ifname} via {gwaddr}\nStrength of {signalStrength}%";
          "format-linked" = " ";
          "format-disconnected" = "⚠";
          "format-alt" = "{ifname}: {ipaddr}/{cidr}";
        };

        "pulseaudio" = {
          "format" = "{icon} {volume}%";
          "format-bluetooth" = "{icon}{volume}% ";
          "format-bluetooth-muted" = " ";
          "format-muted" = " ";
          "format-source" = "{volume}% ";
          "format-source-muted" = "";
          "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = ["" "" ""];
          };
          # "on-click" = "pavucontrol";
        };

				"mpd" = {
					"format" = "{artist} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S})";
					#"format-disconnected" = "Disconnected ";
					"format-stopped" = "";
					"interval" = 10;
					"tooltip-format" = "<img src='/tmp/mpd_art'/>";
					"tooltip-format-disconnected" = "Display art here....";
				};

				/*"image#album-art" = {
					"path" = "/tmp/mpd_art";
					"size" = 32;
					"interval" = 5;
					"on-click" = "mpc toggle";
				};*/

        modules-left = [ "mpd" ];
				modules-center = [ ];
        modules-right = [ "hyprland/window" "pulseaudio" "network" "battery" "clock" ];
      };
    };

    style = 
		  let 
			  marginUD = "0.40em";	
			  marginLR = "0.40em";
			  opacity = "0.9";
			  padUD = "0.40em";
			  padLR = "0.85em";
			  radius = "15px";

			  stdBack = ''
				background-color: rgba(${blackAsDec}, ${opacity});
			'';
			  moduleCSS = ''
				padding: ${padUD} ${padLR};
				margin: ${marginUD} ${marginLR};
				border-radius: ${radius};
				border: 1em;
				box-shadow: 0.2em 0.3em 0 rgba(${blackAsDec}, 0.3);
			'';
		  in ''
            window#waybar {
				font-family: Victor Mono, FontAwesome, monospace;
				font-size: 18px;
				padding: 0 0.7em;
				background: rgba(${blackAsDec}, 0.0);
                color: ${base05};
        }

			#window {
				font-style: italic;
                color: ${base05};
				${moduleCSS}
				${stdBack}
			}

			window#waybar.empty #window  {
				background: transparent;
				box-shadow: -0.3em 0.4em 0 rgba(${blackAsDec}, 0.0);
			}

            tooltip {
                background: rgba(${blackAsDec}, 1.0);
                border: 1px solid rgba(100, 114, 125, 0.9);
            }

            tooltip mpd {
				background-color: rgba(${blackAsDec}, 1.0);
				background-image: url("/tmp/mpd_art");
            }

            #workspaces button {
                background-color: rgba(${blackAsDec}, 0.9);
                color: ${base05};
                border-top: 3px solid ${base05};
				${moduleCSS}
				${stdBack}
            }

			#workspaces button.active {
				color: ${base0B};
				${moduleCSS}
				${stdBack}
			}

            #workspaces button.focused {
				color: ${base00};
                background: ${base04};
                border-bottom: 3px solid ${base0D};
				${moduleCSS}
				${stdBack}
            }

			#mpd {
				font-style: italic;
				${moduleCSS}
				${stdBack}
			}

			#mpd.stopped {
				background-color: transparent;
			}

            #clock {
				font-weight: bold; 
				${moduleCSS}
				${stdBack}
            }

			#pulseaudio {
				font-weight: bold;
				${moduleCSS}
				${stdBack}
			}

            #battery {
				font-weight: bold;
                background-color: ${base0B};
                color: ${base00};
				${moduleCSS}
            }

            #battery.charging {
				font-weight: bold;
                color: ${base00};
                background-color: ${base0D};
				${moduleCSS}
            }

            @keyframes blink {
                to {
                    background-color: ${base05};
                    color: ${base00};
                }
            }

            #battery.warning:not(.charging) {
                background: ${base0C};
                color: ${base05};
                animation-name: blink;
                animation-duration: 0.5s;
                animation-timing-function: linear;
                animation-iteration-count: infinite;
                animation-direction: alternate;
				${moduleCSS}
            } 

			#network {
				font-weight: bold;
				${moduleCSS}
				${stdBack}
			}

			#network.disconnected {
				font-weight: bold;
				color: ${base00};
				background-color: ${base08};	
				${moduleCSS}
			}
        '';
  };
}
# Waybar:1 ends here

# Finishing Touch

# Like with our NixOS configuration, we need to end our preamble configuration!


# [[file:../Config.org::*Finishing Touch][Finishing Touch:1]]
]
# Finishing Touch:1 ends here
