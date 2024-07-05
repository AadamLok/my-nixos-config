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
		];
		
		settings = {
			monitor = ", preferred, auto, auto";
			"$terminal" = "kitty";
			"$fileManager" = "dolphin";
			"$menu" = "wofi --show drun";
			"$mod" = "SUPER";
			bind = [
				"$mod, F, exec, firefox"
				"$mod, Q, exec, $terminal"
				"$mod, M, exit"
				"$mod, E, exec, $fileManager"
				"$mod, R, exec, $menu"
				"$mod, C, killactive"
			] 
			++ (
				builtins.concatLists (builtins.genList (
					x: let
						ws = builtins.toString (x);
					in [
						"$mod, ${ws}, workspace, ${toString (x+1)}"
						"$mod SHIFT, ${ws}, movetoworkspace, ${toString (x+1)}"
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
	};
	
	programs.waybar = {
		enable = true;
	};
}
