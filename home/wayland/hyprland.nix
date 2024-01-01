{ self, inputs, lib, pkgs, ... }: 
with inputs;

let
	wallpaper = "~/Pictures/trooper.jpg";

	hyperlandSettings = {
		enable = true;
		settings = {
			monitor = "eDP-1,2256x1504@60,0x0,1";

			general = {
				border_size = 3;
			};

			decoration = {
				rounding = 10;
			};

			exec-once = [
				"mkdir /tmp/hypr"
				#"wal -i ${wallpaper} -n"
				"hyprpaper"
				"waybar"
			];

			misc = {
				enable_swallow = true;
				swallow_regex = "^(kitty)$";
			};

			"$mod" = "SUPER";

			input.kb_options = "ctrl:nocaps";

			bindm = [
				"$mod, mouse:272, movewindow"
				"$mod Shift, mouse:272, resizewindow"
			];
			bind = [
				# Applications
				# "$mod, Space, exec, tofi-run"
				"$mod Shift, F, exec, firefox"
				"$mod, Return, exec, kitty"

				# Actions 
				"$mod, Q, exec, hyprctl dispatch killactive"
				"$mod, F, exec, hyprctl dispatch togglefloating"
				"$mod, Tab, cyclenext"
				"$mod, Tab, bringactivetotop"
				"$mod Shift, Escape, exec, hyprctl dispatch exit"

				# Brightness
				", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
				", XF86MonBrightnessUp, exec, brightnessctl set 10%+"

				# Audio
				", XF86AudioRaiseVolume, exec, pactl -- set-sink-volume 0 +10%"
				", XF86AudioLowerVolume, exec, pactl -- set-sink-volume 0 -10%"
				", XF86AudioMute, exec, pactl -- set-sink-mute 0 toggle"
			] ++ (
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
		};
	};	

in
{
	wayland.windowManager.hyprland = hyperlandSettings;

	xdg.configFile."hypr/hyprpaper.conf".text = ''
		preload = ${wallpaper} 
		wallpaper = eDP-1,${wallpaper}
	'';
}
