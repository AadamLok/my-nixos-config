{ config, pkgs, ... } : {
	home = {
		username = "aadamlok";
		homeDirectory = "/home/aadamlok";
		stateVersion = "23.11";
	};

	programs.bash = {
		enable = true;
		shellAliases = {
			rebuild = "sudo nixos-rebuild switch --flake ~/nixos";
		}	
	};
}
