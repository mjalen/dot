# SSH


# [[file:../../Config.org::*SSH][SSH:1]]
{ lib, pkgs, ... }: {
	services.openssh = {
		enable = true;
		settings = {
			PasswordAuthentication = false;
			KbdInteractiveAuthentication = false;
		};
	};
}
# SSH:1 ends here
