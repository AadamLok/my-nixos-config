{ config, lib, pkgs, ... }:
{
	
	boot = {
		kernelParams = [ "nvidia-drm.modeset=1" ];
		blacklistedKernelModules = lib.mkDefault [ "nouveau" ];
		initrd.kernelModules = [ "nvidia" ];
		kernelModules = [ "nvidia" ];
	};
	
	hardware.graphics = {
		enable = true;
		#driSupport32Bit = true;
	};

	services.xserver.videoDrivers = [ "nvidia" ];

	hardware.nvidia = {
		#forceFullCompositionPipeline = true;
		modesetting.enable = true;
		powerManagement.enable = true;
		powerManagement.finegrained = false;
		open = false;
		nvidiaSettings = true;
		package = config.boot.kernelPackages.nvidiaPackages.stable;
	};
}
