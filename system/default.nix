{ config, inputs, lib, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
    ./ssh.nix
    ./font.nix
    ./persist.nix
    ./pipewire.nix
    ./virt-manager.nix
  ];

  # DO NOT EDIT THESE UNLESS YOU ARE INSTALLING NIXOS!
  # See installation guide in README on how to derive the UUIDs.
  valhalla.hardware = {
    enabled = true;
    encryptedPARTUUID = "de621fe3-c331-4dce-b9a1-378549926a5c";
    bootUUID = "8B1C-B496";
    unencryptedUUID = "2928f631-7856-461e-b8a3-92422a7ea7d6";
  };
}
