{ config, lib, pkgs, ... }:

with lib;
let
	cfg = config.valhalla.theme;
	template = {
		scheme = mkOption { type = types.str; };
		author = mkOption { type = types.str; };
		base00 = mkOption { type = types.str; };
		base01 = mkOption { type = types.str; };
		base02 = mkOption { type = types.str; };
		base03 = mkOption { type = types.str; };
		base04 = mkOption { type = types.str; };
		base05 = mkOption { type = types.str; };
		base06 = mkOption { type = types.str; };
		base07 = mkOption { type = types.str; };
		base08 = mkOption { type = types.str; };
		base09 = mkOption { type = types.str; };
		base0A = mkOption { type = types.str; };
		base0B = mkOption { type = types.str; };
		base0C = mkOption { type = types.str; };
		base0D = mkOption { type = types.str; };
		base0E = mkOption { type = types.str; };
		base0F = mkOption { type = types.str; };
	};
in
{
	options.valhalla.theme.light = template; 
	options.valhalla.theme.dark = template;


	config.valhalla.theme.toRGB = with builtins; (
		rgb: "rgb(${substring 0 2 rgb}, ${substring 2 2 rgb}, ${substring 4 2 rgb})"
	);
	config.valhalla.theme.toRGBA = with builtins; (
		rgb: a: "rgba(${substring 0 2 rgb}, ${substring 2 2 rgb}, ${substring 4 2 rgb}, ${a})"
	);

}
