{ inputs, lib, pkgs, ... }: 
with inputs;

let
	hyperlandSettings = {
		enable = true;
		settings = {
			monitor = "eDP-1,2256x1504@60,0x0,1";

			exec-once = [
				"hyprpaper"
			];

			"$mod" = "SUPER";
			bind = [
				"$mod, F, exec, firefox"
				"$mod, Return, exec, kitty"
				", F7, exec, brightnessctl set 10%-"
				", F8, exec, brightnessctl set 10%+"
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
preload = ~/Pictures/trooper.jpg
wallpaper = eDP-1,~/Pictures/trooper.jpg
	'';
}
