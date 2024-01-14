{ config, lib, pkgs, ... }:

let
	source = pkgs.stdenv.mkDerivation {
		name = "oxocarbon theme";
		src = pkgs.fetchFromGitHub {
			owner = "nyoom-engineering";
			repo = "base16-oxocarbon";
			rev = "v1.0";
			hash = "";
		};

		buildInputs = with pkgs; [ yj ];

		# convert YAML to JSON
		buildPhase = ''
			echo -e base16-oxocarbon-dark.yaml | yj > dark.json  
			echo -e base16-oxocarbon-light.yaml | yj > light.json
		'';

		# copy JSON to $out
		installPhase = ''
			mkdir -p $out	
			cp -r *.json $out/.  
		'';
	};
in with builtins; {
	imports = [
		./.. # import options.valhalla.theme
	];

	valhalla.theme = {
		light = fromJSON (readFile "${source}/light.json");	
		dark = fromJSON (readFile "${source}/dark.json");
	};
}
