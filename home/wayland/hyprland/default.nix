{ self, config, inputs, lib, pkgs, ... }:
with inputs;

let
  hm = config.home.homeDirectory;
  workspace-binds = import ./workspace-binds.nix;
  wallpaper = "${hm}/Pictures/lotr.jpg";
in
{
  systemd.user.tmpfiles.rules = [
    # required for hyprland to open properly.
    "d /tmp/hypr 0755 jalen users - -"
  ];

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
        # "$mod, Space, exec, tofi-run"
        "$mod Shift, F, exec, firefox"
        "$mod, Return, exec, kitty"
        "$mod, E, exec, emacsclient -c"
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
