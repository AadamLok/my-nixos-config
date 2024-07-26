{ pkgs, ... } :
{
	programs.kitty = {
		enable = true;
		settings = {
			background_opacity = "0.7";
			copy_on_select = true;
			tab_bar_edge = "top";
		};
		theme = "VSCode_Dark";
		font = {
			name = "MesloLGS Nerd Font Mono";
			size = 10;
		};
	};	
} 
