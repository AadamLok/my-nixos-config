{ config, pkgs, inputs, lib, google_api_key, ... } : 

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
	#time.timeZone = "UTC";#"America/New_York";
	services.automatic-timezoned.enable = true;
	location.provider = "geoclue2";
	services.geoclue2.geoProviderUrl = "https://www.googleapis.com/geolocation/v1/geolocate?key=${(builtins.readFile config.age.secrets.google_api_key.path)}";
	services.geoclue2.enableWifi = false;

	# Internationalisation Property
	i18n.defaultLocale = "en_US.UTF-8";
	
	# Enabling GPU Drivers
	hardware.graphics.enable = true;

	# X11 Windowing System
	services.xserver = {
		enable = false;
		xkb = {
			variant = "";
			layout = "us";
		};
		wacom.enable = true;
	};

	services.libinput = {
		enable = true;
		touchpad.tapping = false;
		touchpad.naturalScrolling = true;
	};

	# KDE Plasma Desktop Environment
	services.displayManager.sddm = {
		enable = true;
		wayland.enable = true;
		theme = "chili";
	};
	#services.desktopManager.plasma6.enable = true;

	# Sound Managment with Pipewire
	#sound.enable = true;
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
		automatic-timezoned
		vim
		zsh
		wget
		git
		nixos-icons
		xdg-utils
		home-manager
		waybar
		libnotify
		mako
		swww
		kitty
		wofi
		vscode
		libsForQt5.qt5ct
		libsForQt5.qtstyleplugin-kvantum
		libsForQt5.dolphin
		libsForQt5.breeze-icons
		rnote
		python3
		gnumake
		brightnessctl
		wl-clipboard
		clipse
		hyprshade
		iwgtk
		udiskie
		hyprshot
		libsForQt5.gwenview
		gcc-unwrapped
		lm_sensors
		sddm-chili-theme
		openconnect
	];

	environment.variables.QT_QPA_PLATFORMTHEME = "qt5ct";
	environment.sessionVariables.NIXOS_OZONE_WL = "1";	


	programs = {
		firefox.enable = true;
		hyprland = {
			enable = true;
			package = inputs.hyprland.packages."${pkgs.system}".hyprland;
			xwayland.enable = true;
		};
		zsh.enable = true;
		gnupg.agent = {
			enable = true;
			enableSSHSupport = true;
		};
	};

	xdg = {
		portal = {
			enable = true;
			extraPortals = [
			];
			wlr.enable = true;
		};
		autostart.enable = true;
		icons.enable = true;
		menus.enable = true;
		mime.enable = true;
	};

	nixpkgs.config.qt5 = {
	 	enable = true;
		platformTheme = "qt5ct"; 
		style = {
			package = pkgs.utterly-nord-plasma;
			name = "Utterly Nord Plasma";
		};
	};


	# System Version NEVER CHANGE
	system.stateVersion = "24.05";
	
}
