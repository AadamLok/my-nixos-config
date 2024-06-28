{ config, pkg, ... } : 

{
	imports = [
		./hardware-configuration.nix
	];

	# Boot Loader for efi files
	boot.loader.efi.canTouchEfiVariables = true;
	
	# Making grub the boot loader handler
	boot.grub = {
		enable = true;
		efiSUpport = true;
		device = "nodev";
		useOSProber = true;
		gfxmodeEfi = "1280x720";
		gfxmodeBios = "1280x720";
	};

	# Enable Flake and nix commands
	nix.settings.experimental-features = [
		"nix-command"
		"flakes"
	];

	# Networking
	networking = {
		hostName = "NixOS - NeuralBeast";
		networkmanager.enable = true;
		wireless.enable = true;
	};

	# Setting Time-Zone
	time.timeZone = "America/New_York";

	# Internationalisation Property
	i18n.defaultLocale = "en_US.UTF-8";

	# X11 Windowing System
	services.xserver = {
		enable = true;
		videoDriver = [ "nvidia" ];
		layout = "us";
		xkbVariant = "";
	};

	# KDE Plasma Desktop Environment
	services.displayManager.sddm.enable = true;
	services.desktopManager.plasma5.enable = true;

	# Sound Managment with Pipewire
	sound.enable = true;
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	}

	# Define User Account
	users.users.aadamlok = {
		isNormalUser = true;
		description = "Aadam Lokhandwala";
		extraGroups = [ 
			"networkmanager" 
			"wheel"
		];
		packages = with pkgs; [
			kate
		]
	};

	# Install FireFox
	programs.firefox.enable = true;

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	# System Wide Packages
	environment.systemPackages = with pkgs; [
		vim
		wget
		git
	];

	# System Version NEVER CHANGE
	system.stateVersion = "23.11";
	
}
