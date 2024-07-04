{ config, pkgs, inputs, ... } :
{
	wayland.windowManager.hyprland = {
		enable = true;
		
		plugins = [
			inputs.hyprland.plugins.packages."${pkgs.system}".borders-plus-plus
		];
		
		settings = {
			"plugin:borders-plus-plus" = {
				add_border = 1;
				"col.border_1" = "rgb(ffffff)";
				"col.border_2" = "rgb(2222ff)";
				border_size_1 = 10;
				border_size_2 = -1;
				
				natural_rounding = "yes";
			};
		};
	}
}
