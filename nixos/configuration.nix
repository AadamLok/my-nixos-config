{ config, pkgs, ... } : 

{
	imports = [
		./hardware-configuration.nix
		#./nvidia-rtx.nix
	];

	# Boot Loader for efi files
	boot.loader.efi.canTouchEfiVariables = true;
	
	# Making grub the boot loader handler
	boot.loader.grub = {
		enable = true;
		efiSupport = true;
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

	# Enable Garbage Collection
	nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 15d";
	};

	# Networking
	networking = {
		hostName = "nixos";
		networkmanager.enable = true;
		#wireless.enable = true;
	};

	# Setting Time-Zone
	time.timeZone = "America/New_York";

	# Internationalisation Property
	i18n.defaultLocale = "en_US.UTF-8";
	
	# Enabling GPU Drivers
	hardware.graphics.enable = true;

	# X11 Windowing System
	services.xserver = {
		enable = true;
		xkb = {
			variant = "";
			layout = "us";
		};
	};

	# KDE Plasma Desktop Environment
	services.displayManager.sddm = {
		enable = true;
		theme = "breeze";
	};
	services.desktopManager.plasma6.enable = true;

	# Sound Managment with Pipewire
	sound.enable = true;
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};

	# Define User Account
	users.users.aadamlok = {
		isNormalUser = true;
		description = "Aadam Lokhandwala";
		extraGroups = [ 
			"networkmanager" 
			"wheel"
		];
		shell = pkgs.zsh;
		packages = with pkgs; [
			vlc
		];
	};

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	# System Wide Packages
	environment.systemPackages = with pkgs; [
		vim
		zsh
		wget
		git
		nixos-icons
		xdg-utils
		home-manager
	];

	programs = {
		firefox.enable = true;
		zsh.enable = true;
		gnupg.agent = {
			enable = true;
			enableSSHSupport = true;
		};
	};

	xdg = {
		autostart.enable = true;
		icons.enable = true;
		menus.enable = true;
		mime.enable = true;
	};

	# System Version NEVER CHANGE
	system.stateVersion = "24.05";
	
}
