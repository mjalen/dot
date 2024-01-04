{ self, inputs, lib, pkgs, ... }: 
with inputs;

let
	wallpaper = "~/Pictures/gloom_troop.jpg";
in
{
	systemd.user.tmpfiles.rules = [ # required for hyprland to open properly.
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
				"waybar"
			];

			# Window swallowing... which half works.
			# It depends on the program. Image viewers like feh seem to swallow. 
			misc = {
				enable_swallow = true;
				swallow_regex = "^(kitty)$";
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
				", Print, exec, slurp | grim -g - ~/Pictures/Screenshots/$(date +%Y%m%d_%H%M)_screenshot.png"
				"$mod, Print, exec, grim ~/Pictures/Screenshots/$(date +%Y%m%d_%H%M)_screenshot.png"

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

	xdg.configFile."hypr/hyprpaper.conf".text = ''
		preload = ${wallpaper} 
		wallpaper = eDP-1,${wallpaper}
	'';
}
