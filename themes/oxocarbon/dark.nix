{ config, lib, pkgs, ... }:

/*
	Scheme: Oxocarbon Dark
	Source: shaunsingh/IBM
*/

{ # base16 scheme
	imports = [
		./.. # import options.valhalla.theme
	];

	valhalla.theme = {
		# black
		base00 = "#161616";
		base01 = "#262626"; 

		# grey
		base02 = "#393939"; 
		base03 = "#525252"; 

		# white
		base04 = "#dde1e6"; 
		base05 = "#f2f4f8"; 
		base06 = "#ffffff"; 

		# turqoise
		base07 = "#08bdba";
		base08 = "#3ddbd9"; 
		
		# baby blue?
		base09 = "#78a9ff"; 

		# magenta
		base0A = "#ee5396"; 

		# blue
		base0B = "#33b1ff"; 

		# light magenta
		base0C = "#ff7eb6"; 

		# green
		base0D = "#42be65"; 

		# purple
		base0E = "#be95ff"; 

		# cyan
		base0F = "#82cfff";
	};

}
