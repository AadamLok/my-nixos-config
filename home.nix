{ config, pkgs, ... } : {
	home = {
		username = "aadamlok";
		homeDirectory = "/home/aadamlok";
		stateVersion = "23.11";
		packages = with pkgs; [
			neofetch
		]
	};

	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestions.enable = true;
		syntaxHighlighting.enable = true;
		histSize = 10000;
		histFile = "~/.history" 
		shellAliases = {
			ll = "ls -l";
			la = "ls -la";
			rebuild = "sudo nixos-rebuild switch --flake ~/nixos";
		};
		
		ohMyZsh = {
			enable = true;
			theme = "robbyrussell";
			plugins = [
				"sudo" # Hit esc to add sudo to command
				"systemadmin" # Many useful things
				# Important once
				# mkdir, tree
				# clrz -> clear zombie process
				# port_pro -> shows process with port
				# dls -> ls only dirs
				"vi-mode" # vi like feature on shell
				"web-search" # google/youtube/stackoverflow ... will search and open browser
				"copypath" # copypath will copy pwd
				"copyfile" # copyfile ... will copy content of the file to your clipboard
				"dirhistory" # Helps navigate dirs
				# Alt + left => previous dir
				# Alt + right => next dir
				# Alt + up => parent dir
				# Alt + down => first child dir
				"history" # command history
				# h => print history
				# hl => pipe history to less
				# hs => pipe history to grep
				"python" # useful for python
				# mkv [name] => makes virtual env
				# vrun [name] => run [name] virtual env
				# pygrep <text> => looks for <text> in *.py file recursively
				# pyclean => deletes byte-code and cache files
				# pyfind => finds all .py file recursively
			];
		};	
	};
}
