{ config, lib, pkgs, ... }:
{
	# cpu/intel/cpu-only
	hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
	# gpu/intel
	config = {
		boot.initrd.kernelModules = [ 
			config.hardware.intelgpu.driver
		];
		
		environment.variables = {
			VDPAU_DRIVER = lib.mkDefault "va_gl";
		};

		hardware.graphics.extraPackages = with pkgs; [
			intel-vaapi-driver
			intel-media-driver
		];

		hardware.graphics.extraPackages32 = with pkgs.driversi686Linux; [
			intel-vaapi-driver
			intel-media-driver
		];
	};
}
