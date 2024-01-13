{ config, inputs, pkgs, ... }:

let
	userName = "template";
	cfg = config.valhalla.users.${userName};
in
{
	imports = [ ];

	options.valhalla.users.${userName} = {
		enable = mkOption { type = types.bool; };
	};

	config = mkIf cfg.enable {
		# place all user config here or import it.
	};
}
