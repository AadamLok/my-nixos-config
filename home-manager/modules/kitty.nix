{ pkgs, ... } :
{
	programs.kitty = {
		enable = true;
		settings = {
			background_opacity = "0.7";
			copy_on_select = true;
			tab_bar_edge = "top";
		};
		theme = "Adwaita darker";
	};	
} 
