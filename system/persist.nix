{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.valhalla.persist;
in
{
  options.valhalla.persist = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        				Signal whether to persist files and directories on reboot.
        			'';
    };
    persistDir = mkOption {
      type = types.str;
      default = "/nix/persist";
      description = ''
        				String path for defining the persisting directory. All other persisting directories and files are stored here.
        			'';
    };
  };

  config = mkIf cfg.enable {
    # persist
    environment.persistence."${cfg.persistDir}" = {
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/actual"
        "/var/lib/tailscale"
        "/var/lib/systemd/coredump"
        "/etc/ssh"
        "/etc/NetworkManager"
        "/etc/nixos"
        "/var/lib/waydroid/*"
      ];
      files = [
        "/etc/nix/id_rsa"
        "/etc/machine-id"
        "/etc/systemd/resolved.conf" # using nextdns
      ];
      users.jalen = {
        directories = [
          "Documents"
          ".ollama"
          ".local/state/nix/profiles"
          ".local/share/waydroid"
          ".local/share/honkers-launcher"
          ".local/share/honkers-railway-launcher"
          ".ssh"
          ".gnupg"
          "Pictures"
          "Music"
          "VMs"
          ".password-store"
          ".config"
        ];
      };
    };
  };



}
