{ lib, pkgs, ... }: {

    programs.waybar = {
        enable = true;
        settings = {
            mainBar = {
                layer = "top";
                position = "top";
                height = 30;
                output = [ "eDP-1" ];

                "hyprland/workspaces" = {
                    "format" = "<sub>{id}</sub>";
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
                    "format-wifi" = "{essid} ({signalStrength}%) ";
                    "format-ethernet" = "{ipaddr}/{cidr} ";
                    "tooltip-format" = "{ifname} via {gwaddr} ";
                    "format-linked" = "{ifname} (No IP) ";
                    "format-disconnected" = "Disconnected ⚠";
                    "format-alt" = "{ifname}: {ipaddr}/{cidr}";
                };

                "pulseaudio" = {
                    "format" = "{volume}% {icon} {format_source}";
                    "format-bluetooth" = "{volume}% {icon} {format_source}";
                    "format-bluetooth-muted" = " {icon} {format_source}";
                    "format-muted" = " {format_source}";
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
                modules-right = [ "pulseaudio" "battery" "temperature" ];
            };
        };
        style = ''
            * {
                border: none;
                border-radius: 0;
                font-family: Victor Mono Bold, FontAwesome Bold, monospace;
                font-size: 18px;
                min-height: 30px;
            }

            window#waybar {
                background: rgba(25, 25, 25, 0.75);
                border-bottom: 0px solid rgba(100, 114, 125, 0.5);
                color: white;
            }

            tooltip {
                background: transparent;
                border: 1px solid rgba(100, 114, 125, 0.5);
            }

            tooltip label {
                color: white;
            }

            #workspaces button {
                padding: 0 5px;
                background: transparent;
                color: white;
                border-bottom: 3px solid transparent;
            }

            #workspaces button.focused {
                background: #64727D;
                border-bottom: 3px solid white;
            }

            #clock {
                background-color: transparent;
            }

            #battery {
                background-color: #ffffff;
                color: black;
            }

            #battery.charging {
                color: white;
                background-color: #26A65B;
            }

            @keyframes blink {
                to {
                    background-color: #ffffff;
                    color: black;
                }
            }

            #battery.warning:not(.charging) {
                background: #f53c3c;
                color: white;
                animation-name: blink;
                animation-duration: 0.5s;
                animation-timing-function: linear;
                animation-iteration-count: infinite;
                animation-direction: alternate;
            } 
        '';
    };

}