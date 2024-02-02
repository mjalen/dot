# Virt Manager


# [[file:../../Config.org::*Virt Manager][Virt Manager:1]]
{ config, lib, pkgs, ... }: {
	virtualisation.libvirtd.enable = true;
	programs.virt-manager.enable = true;
}
# Virt Manager:1 ends here
