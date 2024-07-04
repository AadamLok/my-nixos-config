{
	description = "My System Configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		
		hyprland = {
			url = "github:hyprwm/Hyprland";
		};

		hyprland-plugins = {
			url = "github:hyprwm/hyprland-plugins";
			inputs.hyprland.follows = "hyprland";
		};
	
	};

	outputs = { nixpkgs, home-manager, ... } @ inputs : let 
		system = "x86_64-linux";
	in {
		
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			inherit system;
			modules = [
				./nixos/configuration.nix
			];	
		};

		homeConfigurations.aadamlok = home-manager.lib.homeManagerConfiguration {
			pkgs = nixpkgs.legacyPackages.${system};
			modules = [
				./home-manager/home.nix
			];
		};
	};
}
