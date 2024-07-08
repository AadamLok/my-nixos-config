 { config, pkgs, inputs, ... }:
{
	programs.vscode = {
		enable = true;
		enableExtensionUpdateCheck = true;
		enableUpdateCheck = true;
		extensions = with pkgs.vscode-extensions; [
			ms-python.python
		];
		globalSnippets = [
		];
		keybindings = [
		];
		languageSnippets = {
		};
		package = pkgs.vscode;
		userSettings = {
		};
		userTasks = {
		};	
	};
}
