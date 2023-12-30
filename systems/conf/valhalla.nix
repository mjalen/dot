{ inputs, lib, pkgs, ... }: 

with inputs;
{

  # Configuration.nix
  networking.hostName = "valhalla"; # Define your hostname.

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # net manager
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  services.automatic-timezoned.enable = true;  

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # host packages.
  environment.systemPackages = with pkgs; [ git vim ];

  # persist
  environment.persistence."/nix/persist" = {
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
		];
	};
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;
  users.users.jalen = {
    isNormalUser = true;
    description = "Jalen Moore";
    home = "/home/jalen";
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.

    /* openssh.authorizedKeys.keyFiles = [
	"/nix/persist/home/jalen/.ssh/github.pub"
    ]; */
    openssh.authorizedKeys.keys = [
    	# framework github pub key
    	"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFB+TOridG2HiKTfPn3H7oNfuRRWUOQY6Dhma2q8t/3K ajalenboi@gmail.com"
    ];
    # eventually want to add hashedPasswordFile
    hashedPasswordFile = "/nix/persist/psk/jalen";
  };

  users.users.root.hashedPasswordFile = "/nix/persist/psk/root";

  # users.users.root.initialHashedPassword = "$y$j9T$MGafuHlTpjb7L.zur1vsn.$Hmk5kOeaNWUqSs1LK49ej0kmt..1wbrsn612jF9tO1.";
  # users.users.jalen.initialHashedPassword = "$y$j9T$MGafuHlTpjb7L.zur1vsn.$Hmk5kOeaNWUqSs1LK49ej0kmt..1wbrsn612jF9tO1.";

  # hyprland is the GUI of choice
  programs.hyprland.enable = true;

  system.stateVersion = "23.11"; 
  nix.settings.experimental-features = "nix-command flakes";
}
