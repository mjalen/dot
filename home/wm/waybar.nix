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
                    "format" = "<sub>{id}</sub>\n{windows}";
                    "on-scroll-up" = "hyprctl dispatch workspace e+1";
                    "on-scroll-down" = "hyprctl dispatch workspace e-1";
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
                # modules-center = [ "sway/window" "custom/hello-from-waybar" ];
                modules-right = [ "pulseaudio" "battery" "temperature" ];
            };
        };
        /*style = ''
            * {
                font-family: Victor Mono, FontAwesome, monospace;
                font-size: 13px;
            }
        '';*/
    };


}