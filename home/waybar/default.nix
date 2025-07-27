{ ... }:
{
  programs.waybar = {
    enable = true;
    style = builtins.readFile ./style.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        height = 64;
        output = [ "eDP-1" ];

        clock = {
          interval = 60;
          format = "{:%d - %H:%M}";
          max-length = 25;
        };

        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = [ "" "" "" "" "" ];
        };

        network = {
          format-wifi = "";
          format-ethernet = "";
          tooltip-format = " {ifname} via {gwaddr}\nStrength of {signalStrength}%";
          format-linked = " ";
          format-disconnected = "⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };

        # mpd = {
        #   format = "{artist} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S})";
        #   format-stopped = "";
        #   interval = 10;
        #   tooltip-format = "<img src='/tmp/mpd_art'/>";
        #   tooltip-format-disconnected = "Display art here....";
        # };

        modules-left = [ ];
        modules-center = [ "clock" ];
        modules-right = [ "wireplumber" "battery" "network" ];
      };
    };
  };

}
