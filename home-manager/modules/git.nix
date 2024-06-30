{config, ...}: {
	programs.git = {
		enable = true;
		userName = "AadamLok";
		userEmail = "alokhandwala@umass.edu";
		signing = {
			signByDefault = true;
			key = "5F5E2449F9156079";
		};
	};
}
