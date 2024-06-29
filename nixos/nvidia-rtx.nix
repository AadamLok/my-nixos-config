{ config, lib, pkgs, ... }:
{
	options = {
		# Define any custom options here if needed.
	};

	config = {
		boot.kernelParams = [ "nvidia-drm.modeset=1" ];

		hardware.opengl = {
			enable = true;
			driSupport = true;
			driSupport32Bit = true;
		};

		services.xserver.videoDrivers = [ "nvidia" ];

		hardware.nvidia = {
			#forceFullCompositionPipeline = true;
			modesetting.enable = true;
			powerManagement.enable = false;
			powerManagement.finegrained = false;
			open = false;
			nvidiaSettings = true;
			package = config.boot.kernelPackages.nvidiaPackages.stable;
		};
	};
}
