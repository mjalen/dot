{ inputs, config, pkgs, ... }: 

with inputs.theme;
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
                    "format-wifi" = " ({signalStrength}%)";
                    "format-ethernet" = " {ipaddr}/{cidr}";
                    "tooltip-format" = " {ifname} via {gwaddr}";
                    "format-linked" = " {ifname} (No IP)";
                    "format-disconnected" = "⚠ Disconnected";
                    "format-alt" = "{ifname}: {ipaddr}/{cidr}";
                };

                "pulseaudio" = {
                    "format" = "{icon} {volume}%";
                    "format-bluetooth" = "{icon}{volume}% ";
                    "format-bluetooth-muted" = "{icon} ";
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

                modules-left = [ "hyprland/workspaces" ];
                modules-center = [ "clock" ];
                modules-right = [ "pulseaudio" "network" "battery" ];
            };
        };
        style = ''
            * {
                border: 4px;
                font-family: Victor Mono Bold, FontAwesome Bold, monospace;
                font-size: 18px;
		min-height: 30px;
            }

            window#waybar {
				background: rgba(${blackAsDec}, 0.9);
                border-bottom: 0px solid rgba(100, 114, 125, 0.5);
                color: ${base05};
            }

            tooltip {
                background: rgba(${blackAsDec}, 0.9);
                border: 1px solid rgba(100, 114, 125, 0.5);
            }

            tooltip label {
                color: white;
            }

            #workspaces button {
                background-color: transparent;
                color: ${base05};
				padding: 0 0.75em;
				margin: 0.25em;
                border-top: 3px solid ${base05};
            }

			# workspaces button.active {
				color: ${base0B};
			}

            #workspaces button.focused {
                background: ${base04};
                border-bottom: 3px solid ${base0D};
            }

            #clock {
	    	padding: 0 0.75em;
                background-color: transparent;
            }

            #battery {
				padding: 0 0.75em;
                background-color: ${base0B};
                color: ${base00};
            }

            #battery.charging {
                color: ${base00};
                background-color: ${base0D};
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
            } 

			#network {
				padding: 0 0.75em;
			}

			#network.disconnected {
				background-color: ${base08};	
			}
        '';
    };

}
