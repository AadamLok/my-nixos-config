{ config, lib, pkgs, ... } : {
	
	hardware.graphics = {
		enable = true;
	};

	services.xserver.videoDrivers = ["nvidia"];

	hardware.nvidia = {
		modesetting.enable = true;
		powerManagement.enable = false;
		powerManagement.finegrained = false;
		open = false;
		nvidiaSettings = true;
		package = config.boot.kernelPackages.nvidiaPackages.stable;
	};
	
	boot.initrd.kernelModules = [ "nvidia" ];
	boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
	boot.blacklistedKernelModules = [ "nouveau" ];
}
