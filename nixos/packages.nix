{ pkgs, ... } : {
	nixpkgs.config = {
		allowUnfree = true;
	};

	environment.systemPackages = with pkgs; [
		# Coding
		vim
		python3
		
		# Productivity
		tmux		

		# For Oh-My-ZSH Shell
		zsh
		oh-my-zsh
		zsh-completions
		zsh-syntax-highlighting
		zsh-history-substring-search
		
		# Utilities
		wget
		gnupg # for gpg key managment
		git

		# NixOS helper
		home-manager
	];
}
