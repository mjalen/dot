# A double function so that I may define which key to use depending on the system.
{ pkgs, lib, ... }: ( 
  let
  	frameworkPubKey = ''
		... Generate/add key once I receive laptop ...
	'';
  	parallelsPubKey = ''
-----BEGIN PGP PUBLIC KEY BLOCK-----

mDMEZYqtBxYJKwYBBAHaRw8BAQdAuXs5c8SCEJlKPwERJc6OHi95/YanBUfsWiGi
eUNjugK0MG1qYWxlbiAocGFyYWxsZWxzIGdpdCBrZXkpIDxhamFsZW5ib2lAZ21h
aWwuY29tPoiOBBMWCgA2FiEEhoDHTi09dqqdJ6bRtbrmdhyaY5QFAmWKrQcCGwME
CwkIBwQVCgkIBRYCAwEAAh4FAheAAAoJELW65nYcmmOUL68BAPc9LTuRddijhNdL
cc+OSGAMDu13R21WpUYjLaI2kLHqAP9ENfa25k0/wbfHE5dEdeKAM0SJ1KHmK0kZ
VwpPQMWICrg4BGWKrQcSCisGAQQBl1UBBQEBB0DbXa+EAJ3Tf/uFxreqRMx+Wxc0
qeFwYkbbgfm3OtVkHAMBCAeIeAQYFgoAIBYhBIaAx04tPXaqnSem0bW65nYcmmOU
BQJliq0HAhsMAAoJELW65nYcmmOU+aABAPqkQhjxI49r4Mq4P8qHoqPUF+mI+ZRO
07TU1d5FedA8AQCbtc4BtT/CaUm0poKxJslEQH1FdXLMtzs7uu4WezFZBA==
=bt8z
-----END PGP PUBLIC KEY BLOCK-----
  '';
  in {
 	programs.gpg = {
		enable = lib.mkDefault true;
		mutableKeys = lib.mkDefault false;
		mutableTrust = lib.mkDefault false;
		publicKeys = [
			{
				text = parallelsPubKey;
				trust = "ultimate";
			}
		];
		settings = {
			use-agent = "";
			pinentry-mode = "loopback";
		};
    	};

    	services.gpg-agent = {
		enable = lib.mkDefault true;
		# enableSshSupport = lib.mkDefault true;
		# enableExtraSocket = lib.mkDefault true;
		pinentryFlavor = "curses";
		extraConfig = ''
			allow-loopback-pinentry
		'';
    	};
     }
)
