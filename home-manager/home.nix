{ config, pkgs, inputs, ... } : {
	home = {
		username = "aadamlok";
		homeDirectory = "/home/aadamlok/";
		stateVersion = "23.11";
		packages = with pkgs; [
			neofetch
		];
	};

	imports = [
		./modules/zsh.nix
		./modules/git.nix
	];
}
