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
			genral = {
				gaps_in = 5;
				gaps_out = 20;
				border_size = 2;
				"col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
				"col.inactive_border" = "rgba(595959aa)";
				resize_on_border = true;
				allow_tearing = false;
				layout = dwindle;
			};
			decoration = {
				rounding = 10;
				active_opacity = 1.0;
				inactive_opacity = 1.0;
				drop_shadow = true;
				shadow_range = 4;
				shadow_render_power = 3;
				"col.shadow" = "rgba(1a1a1aee)";
				blur = {
					enable = true;
					size = 3;
					passes = 1;
					vibrancy = 0.1696;
				};
			};
		};
	};
}
