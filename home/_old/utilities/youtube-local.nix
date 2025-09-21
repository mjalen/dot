{ lib, stdenv, fetchFromGithub, pkgs, ... }: 

stdenv.mkDerivation rec {
	pname = "youtube-local";
	version = "2.8.12";

	src = fetchFromGithub {
		owner = "user234683";
		repo = pname;
		rev = "v${version}";
		sha256 = "f9306ca0c7c3c154dab16ec9ea1a2a3393a31e93";
	};

	buildInputs = with pkgs; [
		(python3.withPackages (p: with p; [
			flask
			gevent
			brotli
			pysocks
			urllib3
			defusedxml
			cachetools
			stem
		]))
	];

	meta = with lib; {
		description = "Youtube Local";
		homepage = "https://github.com/user234683/youtube-local";
		platforms = platforms.linux;
	};
}
