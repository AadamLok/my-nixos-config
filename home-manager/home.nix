{ config, pkgs, ... } : {
	home = {
		username = "aadamlok";
		homeDirectory = "/home/aadamlok";
		stateVersion = "23.11";
		packages = with pkgs; [
			neofetch
		];
	};

	imports = [
		./zsh.nix
	];
}
