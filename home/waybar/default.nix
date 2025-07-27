{ pkgs, ... }:
let
  monitor-orientation =
    (pkgs.writeShellScriptBin "monitor-orientation"
      (builtins.readFile ./monitor-orientation.sh));
  toggle-overview =
    (pkgs.writeShellScriptBin "toggle-overview"
      (builtins.readFile ./toggle-overview.sh));
in
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

        # NOTE This will not work if running waybar through Emacs.
        "custom/niri-overview" = {
          on-click = "${toggle-overview}/bin/toggle-overview";
          format = "&#xf0c9;";
        };

        "custom/screen-orientation" = {
          exec = "${monitor-orientation}/bin/monitor-orientation";
          exec-if = "${monitor-orientation}/bin/monitor-orientation";
          return-type = "json";
          on-click = "niri-lock-rotation";
          restart-interval = 1;
          format = "{icon}";
          format-icons = {
            locked = "&#xf023;";
            unlocked = "&#xf3c1;";
          };
        };

        clock = {
          interval = 60;
          format = "{:%d - %I:%M}";
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

        wireplumber = {
          format = "{volume}% {icon}";
          format-icons = [ "&#xf026;" "&#xf027;" "&#xf028;" ];
          format-muted = "Muted &#xf6a9;";
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          scroll-step = 5;
        };

        modules-left = [ "custom/niri-overview" ];
        modules-center = [ "clock" ];
        modules-right = [ "custom/screen-orientation" "wireplumber" "battery" "network" ];
      };
    };
  };

}
