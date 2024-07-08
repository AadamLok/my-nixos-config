{ pkgs, ... } :
{
	programs.kitty = {
		enable = true;
		settings = {
			background_opacity = "0.7";
		};
		theme = "Adwaita darker";
	};	
} 
