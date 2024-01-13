{ config, lib, pkgs, ... }: 

with lib;
let
	cfg = config.valhalla.wayland.waybar;
in
{
	imports = [
		./pills.nix
	];

	options.valhalla.wayland.waybar = {
		enable = mkOption {
			type = types.bool;
		};

		barType = mkOption {
			type = types.str;
		};
	};

	config = mkIf cfg.enable {
		cfg.${barType}.enable = true;	
	};
}
