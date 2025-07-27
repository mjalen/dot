/*
TODO niri
  - On screen keyboard for tablet.
	- waybar with auto-rotation lock and wireplumber controls
*/
{ config, pkgs, wallpaper, ... }:
let
  wallpaperStr = builtins.toString wallpaper;
in
{
  home.packages = with pkgs; [ xwayland-satellite ];
  programs.niri.enable = true;
  programs.niri.package = pkgs.niri-unstable;

  programs.niri.settings = {
    environment = {
      "DISPLAY" = ":0";      
    };

    spawn-at-startup = [
      { command = [ "waybar" ]; }
      { command = [ "swww-daemon" ]; }
      { command = [ "swww" "img" wallpaperStr ]; }
      { command = [ "niri-auto-rotate" ]; }
      { command = [ "xwayland-satellite" ]; }
    ];

    prefer-no-csd = true;

    outputs."eDP-1" = {
      mode = {
        width = 1600;
        height = 2560;
        refresh = 60.0;
      };
      transform = {
        rotation =  270;
      };
      scale = 2.0;
    };

    input.keyboard.xkb = {
      layout = "us";
      options = "ctrl:nocaps";
    };

    input.tablet.map-to-output = "eDP-1";
    input.touch.map-to-output = "eDP-1";

    # layer-rules = [
    #   {
    #     matches = [
    #       { namespace = "waybar"; }
    #     ];
    #     place-within-backdrop = true;
    #   }
    #  ];
    window-rules = [
      {
        geometry-corner-radius = let radius = 8.0; in {
          top-left = radius;
          top-right = radius; 
          bottom-right = radius;
          bottom-left = radius;
        };
        clip-to-geometry = true;
      }
      {
        matches = [{ app-id = "Emacs"; }];
        opacity = 0.92;
      }
    ];

    layout = {
      always-center-single-column = true;
      gaps = 12;
      focus-ring.enable = false;

      border = {
        enable = true;
        width = 8;
        inactive.color = "#00000077"; # "#6e1a3a99";
        active.color = "#00000077"; # "#171a4799";
      };

      struts = let
        inline = 8;
        block = 0;
      in {
        left = inline;
        right = inline;
        top = block;
        bottom = block;
      };
    };

    binds = with config.lib.niri.actions; {
      "Mod+Ctrl+Return".action = spawn "emacs";
      "Mod+Return".action = spawn "emacsclient" "-c";
      "Mod+Shift+Return".action = spawn "systemctl" "--user" "restart" "emacs.service";
      "Mod+Shift+Slash".action = show-hotkey-overlay;
      "Mod+Space".action = spawn "fuzzel";

      "Mod+R".action = spawn "niri-lock-rotation";
      "Mod+Shift+W".action = spawn "swww" "img" wallpaperStr;
      
      "XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";
      "XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";

      # TODO Fix to actually mute.
      "XF86AudioMute".action = spawn  "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.0";
      "XF86AudioMicMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
 
      "XF86MonBrightnessUp".action = spawn "brightnessctl" "--class=backlight" "set" "+10%";
      "XF86MonBrightnessDown".action = spawn "brightnessctl" "--class=backlight" "set" "10%-";

      "Mod+O" = {
        action = toggle-overview; 
        repeat = false;
      };

      
      "Mod+Q" = {
        action = close-window;
        repeat = false;
      };

      "Mod+H".action = focus-column-left;
      "Mod+J".action = focus-window-down;
      "Mod+K".action = focus-window-up;
      "Mod+L".action = focus-column-right;

      "Mod+Ctrl+H".action = move-column-left;
      "Mod+Ctrl+J".action = move-window-down;
      "Mod+Ctrl+K".action = move-window-up;
      "Mod+Ctrl+L".action = move-column-right;
      
      "Mod+Shift+H".action = focus-monitor-left;
      "Mod+Shift+J".action = focus-monitor-down;
      "Mod+Shift+K".action = focus-monitor-up;
      "Mod+Shift+L".action = focus-monitor-right;

      "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
      "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
      "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
      "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;

      "Mod+WheelScrollDown" = {
        action = focus-workspace-down;
        cooldown-ms = 150;
      };

      "Mod+WheelScrollUp" = {
        action = focus-workspace-up;
        cooldown-ms = 150;
      };

      "Mod+Ctrl+WheelScrollDown" = {
        action = move-column-to-workspace-down;
        cooldown-ms = 150;
      };

      "Mod+Ctrl+WheelScrollUp" = {
        action = move-column-to-workspace-up;
        cooldown-ms = 150;
      };

      "Mod+Shift+E".action = quit;
      "Ctrl+Alt+Delete".action = quit;
      
      "Mod+Minus".action = set-column-width "-10%";
      "Mod+Equal".action = set-column-width "+10%";

      "Mod+1".action = focus-workspace 1;
      "Mod+2".action = focus-workspace 2;
      "Mod+3".action = focus-workspace 3;
      "Mod+4".action = focus-workspace 4;
      "Mod+5".action = focus-workspace 5;
      "Mod+6".action = focus-workspace 6;
      "Mod+7".action = focus-workspace 7;
      "Mod+8".action = focus-workspace 8;
      "Mod+9".action = focus-workspace 9;
      # "Mod+Ctrl+1".action = move-column-to-workspace 1;
      # "Mod+Ctrl+2".action = move-column-to-workspace 2;
      # "Mod+Ctrl+3".action = move-column-to-workspace 3;
      # "Mod+Ctrl+4".action = move-column-to-workspace 4;
      # "Mod+Ctrl+5".action = move-column-to-workspace 5;
      # "Mod+Ctrl+6".action = move-column-to-workspace 6;
      # "Mod+Ctrl+7".action = move-column-to-workspace 7;
      # "Mod+Ctrl+8".action = move-column-to-workspace 8;
      # "Mod+Ctrl+9".action = move-column-to-workspace 9;

      "Mod+WheelScrollRight".action = focus-column-right;
      "Mod+WheelScrollLeft".action = focus-column-left;
      "Mod+Ctrl+WheelScrollRight".action = move-column-right;
      "Mod+Ctrl+WheelScrollLeft".action = move-column-left;
      
      "Mod+F".action = maximize-column;
      "Mod+Shift+F".action = fullscreen-window;
      "Mod+Ctrl+F".action = expand-column-to-available-width;
    };
  };
}
