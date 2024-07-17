{ config, pkgs, inputs, ... }:
{
	programs.wofi = {
		enable = true;
		settings = {
			location = "center";
			allow_markup = true;
			width = "50%";
		};
		style = ''
			
		'';
	}
}
