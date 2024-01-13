{ config, lib, pkgs, ... }: 

with lib;
let
	cfg = config.valhalla.wayland.waybar.pills;
in 
{
	options.valhalla.wayland.waybar.pills = { 
		enable = mkOption { type = types.bool; }; 
	};

	config = mkIf cfg.enable {
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
	};
}
