{ config, lib, pkgs, modulesPath, ... }:

with lib;
let
  cfg = config.valhalla.hardware;
in
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  options.valhalla.hardware = {
    enabled = mkOption { type = types.bool; };
    encryptedPARTUUID = mkOption { type = types.str; };
    unencryptedUUID = mkOption { type = types.str; }; # 534cebad-1be2-4bdb-982d-835da3f6240a
    bootUUID = mkOption { type = types.str; };
    headerPARTUUID = mkOption { type = types.str; };
  };

  config = mkIf cfg.enabled {
    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" =
      {
        device = "/dev/disk/by-uuid/${cfg.unencryptedUUID}";
        fsType = "btrfs";
        options = [ "subvol=root" ];
      };

    # luks boot info
    boot.initrd.luks.devices = {
      crypted = {
        device = "/dev/disk/by-partuuid/${cfg.encryptedPARTUUID}"; # 9c41d5e1-8b1f-42cb-8bdc-8edd51973791
        # header = "/dev/disk/by-partuuid/${cfg.headerPARTUUID}"; # 23a9e2b8-d901-411a-a5f9-ea893072a5f4 
        allowDiscards = true;
        preLVM = true;
      };
    };

    fileSystems."/persist" =
      {
        device = "/dev/disk/by-uuid/${cfg.unencryptedUUID}";
        fsType = "btrfs";
        neededForBoot = true;
        options = [ "subvol=persist" ];
      };

    fileSystems."/nix" =
      {
        device = "/dev/disk/by-uuid/${cfg.unencryptedUUID}";
        fsType = "btrfs";
        options = [ "subvol=nix" ];
      };

    fileSystems."/boot" =
      {
        device = "/dev/disk/by-uuid/${cfg.bootUUID}";
        fsType = "vfat";
      };

    swapDevices = [ ];

    boot.initrd.postDeviceCommands = lib.mkAfter ''
      			mkdir /btrfs_tmp
      			mount /dev/disk/by-uuid/${cfg.unencryptedUUID} /btrfs_tmp
      			if [[ -e /btrfs_tmp/root ]]; then
      				mkdir -p /btrfs_tmp/backups
      				timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
      				mv /btrfs_tmp/root "/btrfs_tmp/backups/$timestamp"
      			fi

      			delete_subvolume_recursively() {
      				IFS=$'\n'
      				for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
      					delete_subvolume_recursively "/btrfs_tmp/$i"
      				done
      				btrfs subvolume delete "$1"
      			}

      			for i in $(find /btrfs_tmp/backups/ -maxdepth 1 -mtime +30); do
      				delete_subvolume_recursively "$i"
      			done

      			btrfs subvolume create /btrfs_tmp/root
      			umount /btrfs_tmp
      		'';

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    networking.useDHCP = lib.mkDefault true;
    # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
