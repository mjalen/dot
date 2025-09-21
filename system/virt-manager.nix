{ config, lib, pkgs, ... }:

{
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  virtualisation.spiceUSBRedirection.enable = true;
  users.groups.libvirtd.members = [ "jalen" ];
}
