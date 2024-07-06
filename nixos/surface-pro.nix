{ config, lib, pkgs, ... }:
{

	services.iptsd.enable = lib.mkDefault true;
	environment.systemPackages = with pkgs; [
		surface-control
	];

	services.thermald = lib.mkDefault {
		enable = true;
		configFile = ./surface-thermal-conf.xml;
	};

	boot.blacklistedKernelModules = lib.optionals (!config.hardware.enableRedistributableFirmware) [
		"ath3k"
	];
	
	services.fstrim.enable = lib.mkDefault true;

	# cpu/intel/cpu-only
	hardware.cpu.intel.updateMicrocode = true;
	
	# gpu/intel
	boot.initrd.kernelModules = [ 
		"i915"
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

	# surface/common
	boot.kernelParams = lib.mkDefault [ "mem_sleep_default=deep" ];

	services.tlp.enable = lib.mkDefault false;
	
	hardware.enableRedistributableFirmware = lib.mkDefault true;
	hardware.sensor.iio.enable = lib.mkDefault true;
}
