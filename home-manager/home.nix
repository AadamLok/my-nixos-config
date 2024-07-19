{ config, pkgs, inputs, ... } : {
	home = {
		username = "aadamlok";
		homeDirectory = "/home/aadamlok/";
		stateVersion = "23.11";
		packages = with pkgs; [
			neofetch
		];
	};

	nixpkgs.config.allowUnfree = true;

	imports = [
		./modules/zsh.nix
		./modules/git.nix
		./modules/hyprland.nix
		./modules/fonts.nix
		./modules/waybar/default.nix
		./modules/kitty.nix
		./modules/vscode.nix
		./modules/mako.nix
		./modules/wofi.nix
	];
}
