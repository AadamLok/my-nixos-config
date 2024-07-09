{config, pkgs, ...}:
{
	services.mako = {
		enable = true;
		
		actions = true;
		anchor = "top-right";

		backgroundColor = "#1D1D1DEE";
		borderRadius = 10;
		borderColor = "#33CCFFEE";

		defaultTimeout = 10000;
	};
}
