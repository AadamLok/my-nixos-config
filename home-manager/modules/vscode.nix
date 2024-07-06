 { config, pkgs, inputs, ... }:
{
	programs.vscode = {
		enable = true;
		enableExtensionUpdateCheck = true;
		enableUpdateCheck = true;
		extensions = [
		];
		globalSnippets = [
		];
		keybindings = [
		];
		languageSnippets = {
		};
		package = pkgs.vscodium;
		userSettings = {
		};
		userTasks = {
		};	
	};
}
