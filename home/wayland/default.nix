{ config, lib, pkgs, ... }:

with lib;
let
	cfg = config.valhalla.wayland;
in
{
	imports = [
		./hyprland
		./waybar
	];

	options.valhalla.wayland = {
		enable = mkOption {
			type = types.bool;	
		};

		bar = mkOption {
			type = types.str;	
		};

		windowManager = mkOption {
			type = types.str;
		};
	};

	config = mkIf cfg.enable {
		cfg.${windowManager}.enable = true;
		cfg.${bar}.enable = true;
	};
}
