#! /bin/sh
# Script to partition SSD and configure filesystems. (For fresh installs only!) 

# require block device to partition.
if [[ -e $1 ]]; then
	echo "WARNING! This is an un-tested and incomplete. As such, we will auto-terminate for you :)"  
	echo "\tIf you are serious about running this script, remove the marked exit command."

	exit; # MARKED! You are crazy if you remove me! Be warned that by doing so, I am not responsible for bricking your computer!

	echo "Attempting to format $1."	

	# verify root priviledges.
	if [ $EUID -ne 0 ]; then
		echo "\tERROR: Root priviledges are required. Terminating.... "	
		exit
	fi

	# run partitioning. using `parted`
	parted $1 -- mklabel gpt &
	parted $1 -- mkpart esp fat32 1MB 512MB &
	parted $1 -- mkpart root btrfs 512MB 100% &
	parted $1 -- set 1 esp on;

	# check that partitions were created.
	echo "Verifying partitions..."
	espGrep=$(parted $1 -- print | grep esp)
	rootGrep=$(parted $1 -- print | grep root)

	if [ $espGrep -e 0 -o $rootGrep -e 0 ]; then
		echo "\tERROR: Failed to properly partition. Terminating..." # TODO in the case of failure, leaves side-effects. Remove this risk?	
		exit
	fi
	echo "\t STATUS: Partitions successfully created.\n"


	echo "Encrypting root drive... Answer the following prompts:"
	cryptsetup -y -v luksFormat /dev/disk/by-partlabel/root

	echo "Opening encrypted partition..."
	cryptsetup open /dev/disk/by-partlable/root root 

	echo "Formatting filesystems..."
	mkfs.btrfs /dev/mapper/root # unencrypted block device
	mkfs.fat -F 32 -n esp /dev/disk/by-partlabel/esp

	echo "Creating BTRFS subvolumes /nix and /root" 
	mkdir /tmp/root
	mount /dev/mapper/root -o compress-force=zstd,noatime,ssd /tmp/root

	pushd /tmp/root
	btrfs subvolume create nix
	btrfs subvolume create root


	

fi 

echo "Missing block device name.\n\tExample: /dev/sda or /dev/nvme0n1"
