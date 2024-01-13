{ config, lib, pkgs, ... }:

with lib;
let 
	cfg = config.valhalla.users;
in
{
	imports = [
		./jalen 
	];

	options.config.valhalla.users = {
		enable = mkOption { type = types.bool; };
		users = with types; { type = listOf str; };
	};

	# hopefully this works.
	config = with builtins; mkIf cfg.enable (
		listToAttrs (
			map (user: { name = "${cfg}.${user}.enable" ; value = true; }) 
				cfg.users
		)
	);
}
