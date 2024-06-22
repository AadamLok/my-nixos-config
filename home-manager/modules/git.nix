{config, ...}: {
	programs.git = {
		enable = true;
		userName = "AadamLok";
		userEmail = "alokhandwala@umass.edu";
		signing.signByDefault = true;
	};
}
