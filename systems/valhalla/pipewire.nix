# Pipewire

# For microphones.


# [[file:../../Config.org::*Pipewire][Pipewire:1]]
{ config, lib, pkgs, ... }: {
	security.rtkit.enable = true;
	services.pipewire = {
		pulse.enable = true;
	};
}
# Pipewire:1 ends here
