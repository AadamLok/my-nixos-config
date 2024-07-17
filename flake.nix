{
	description = "My System Configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		
		nixos-hardware = {
			url = "github:NixOS/nixos-hardware/master";
		};
		
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		
		hyprland = {
			url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		hyprland-plugins = {
			url = "github:hyprwm/hyprland-plugins";
			inputs.hyprland.follows = "hyprland";
		};	
	};

	outputs = { nixpkgs, home-manager, nixos-hardware, ... } @ inputs : let 
		system = "x86_64-linux";
	in {
		
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			inherit system;
			specialArgs = {
        			inherit inputs;
      			};
			modules = [
				./nixos/configuration.nix
				nixos-hardware.nixosModules.microsoft-surface-pro-intel
			];	
		};

		homeConfigurations.aadamlok = home-manager.lib.homeManagerConfiguration {
			pkgs = nixpkgs.legacyPackages.${system};
			extraSpecialArgs = {
				inherit inputs;
			};
			modules = [
				./home-manager/home.nix
			];
		};
	};
}
