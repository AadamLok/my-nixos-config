{ config, pkgs, ... }:

{
	nixpkgs.config = {
		allowUnfree = true;
	};

	environment.systemPackages = with pkgs; [
		# Desktop App
		vlc
		
		# Coding
		vim
		python3
		sqlite

		# Productivity
		tmux
		hyprland

		# For Oh-My-ZSH
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
		gum # Something to explore

		# NixOS helper
		home-manager
	];
} 
