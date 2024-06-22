{ config, pkgs, ... } : {
	home = {
		username = "aadamlok";
		homeDirectory = "/home/aadamlok";
		stateVersion = "23.11";
	};

	programs.zsh = {
		enable = true;
		shellAliases = {
			ll = "ls -l";
			la = "ls -a";
			lla = "ls -la";
			rebuild = "sudo nixos-rebuild switch --flake ~/nixos";
		}	
	};
}
