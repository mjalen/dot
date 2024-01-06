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
				"/var/lib/systemd/coredump"
				"/etc/ssh"
				"/etc/NetworkManager"
				"/etc/nixos"
			];
			files = [
				"/etc/nix/id_rsa"
				"/etc/machine-id"
			];
			users.jalen = {
				directories = [
					"Documents"
					".local/state/nix/profiles"
					".ssh"
					".gnupg"
					"Pictures"
					"Music"
					"VMs"
				];
			};
		};
	};

	

}
