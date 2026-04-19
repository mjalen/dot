{ config, inputs, lib, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
    ./ssh.nix
    ./font.nix
    ./persist.nix
    ./pipewire.nix
    ./virt-manager.nix
    ./tlp.nix
  ];

  # DO NOT EDIT THESE UNLESS YOU ARE INSTALLING NIXOS!
  # See installation guide in README on how to derive the UUIDs.
  valhalla.hardware = {
    enabled = true;
    encryptedPARTUUID = "11f567d6-1d5f-4b3a-b153-5fc6055d318d";
    bootUUID = "1104-9330";
    unencryptedUUID = "d0116501-5094-4104-b274-5890c21086fa";
  };
}
