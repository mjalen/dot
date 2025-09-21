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
    encryptedPARTUUID = "b55429d1-cda6-42b6-9949-c074cf944ff0";
    bootUUID = "B047-820D";
    unencryptedUUID = "f11591fb-0911-4d15-a400-4e7e64e60b38";
  };
}
