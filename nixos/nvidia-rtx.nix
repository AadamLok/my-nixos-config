{ config, lib, pkgs, ... } : {
	
	hardware.graphics = {
		enable = true;
		enable32Bit = lib.mkDefault true;

		extraPackages = with pkgs; [
			nvidia-vaapi-driver
			libvdpau
			libvdpau-va-gl
		];
	};

	services.xserver.videoDrivers = ["nvidia"];

	hardware.nvidia = {
		modesetting.enable = true;
		nvidiaPersistenced = true;
		powerManagement.enable = true;
		powerManagement.finegrained = false;
		open = false;
		nvidiaSettings = true;
		package = config.boot.kernelPackages.nvidiaPackages.unstable;
	};
	
	boot.blacklistedKernelModules = [ "nouveau" ];
	boot.initrd.kernelModules = [ "nvidia" ];
	boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];

	environment.variables = {
		GBM_BACKEND = "nvidia-drm";
		LIBVA_DRIVER_NAME = "nvidia";
		__GLX_VENDOR_LIBRARY_NAME = "nvidia";
	};

	environment.systemPackages = with pkgs; [
		clinfo
		gwe
		nvtopPackages.nvidia
		virtualglLib
		vulkan-loader
		vulkan-tools
	];
}
