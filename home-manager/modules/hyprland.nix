{ config, pkgs, inputs, ... } :
let
	startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
		${pkgs.waybar}/bin/waybar &
		${pkgs.swww}/bin/swww init &
	'';
in
{
	wayland.windowManager.hyprland = {
		enable = true;
		
		plugins = [
			inputs.hyprland-plugins.packages."${pkgs.system}".borders-plus-plus
		];
		
		settings = {
			"$mod" = "SUPER";
			bind = [
				"$mod, F, exec, firefox"
			] 
			++ (
				builtins.concatLists (builtins.genList (
					x: let
						ws = let
							c = (x+1)/10;
						in
							builtins.toString (x+1 - (c*10));
					in [
						"$mod, ${ws}, workspace, ${toString (x+1)}"
						"$mod, SHIFT, ${ws}, movetoworkspace, ${toString (x+1)}"
					]
				)
				10)
			);
			exec-once = ''${startupScript}/bin/start'';
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
