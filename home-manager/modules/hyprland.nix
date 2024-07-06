{ config, pkgs, inputs, ... } :
let
	startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
		${pkgs.waybar}/bin/waybar &
		${pkgs.swww}/bin/swww init &
		sleep 1
		${pkgs.swww}/bin/swww img ~/Pictures/hyprland_anime_wallpaper.png
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
						"$mod, ${ws}, workspace, ${toString (x)}"
						"$mod SHIFT, ${ws}, movetoworkspace, ${toString (x)}"
					]
				)
				10)
			);
			exec-once = ''${startupScript}/bin/start'';
			general = {
				gaps_in = 5;
				gaps_out = "10 20 20 20";
				border_size = 2;
				"col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
				"col.inactive_border" = "rgba(595959aa)";
				resize_on_border = true;
				layout = "dwindle";
			};
			decoration = {
				rounding = 10;
				active_opacity = 1.0;
				inactive_opacity = 1.0;
				drop_shadow = true;
				shadow_range = 4;
				shadow_render_power = 3;
				"col.shadow" = "rgba(1a1a1aee)";
				#blur = {
				#	enabled = true;
				#	size = 3;
				#	passes = 1;
				#	vibrancy = 0.1696;
				#};
			};
			animations = {
				enabled = true;
				bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
				animation = [
					"windows, 1, 7, myBezier"
					"windowsOut, 1, 7, default, popin 80%"
					"border, 1, 10, default"
					"borderangle, 1, 8, default"
					"fade, 1, 7, default"
					"workspaces, 1, 6, default"
				];
			};
		};
	};
}
