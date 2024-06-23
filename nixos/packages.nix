{ pkgs, ... } : {
	nixpkgs.config = {
		allowUnfree = true;
		allowUnsupportedSystem = true;
	};

	environment.systemPackages = with pkgs; [
		# Desktop Apps
		teams
		zoom-us
		vlc

		# Coding
		vim
		python3
		sqlite
		
		# Productivity
		tmux
		hyprland		

		# For Oh-My-ZSH Shell
		zsh
		oh-my-zsh
		zsh-completions
		zsh-syntax-highlighting
		zsh-history-substring-search
		
		# Utilities
		wget
		gnupg
		git
		tree
		htop
		unzip
		zip
		gum # is something I want to look into

		# NixOS helper
		home-manager
	];
}
