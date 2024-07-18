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

		agenix = {
			url = "github:ryantm/agenix";
			inputs.nixpkgs.follows = "nixpkgs";
		};	
	};

	outputs = { nixpkgs, home-manager, nixos-hardware, agenix, ... } @ inputs : let 
		system = "x86_64-linux";
	in {
		
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			inherit system;
			specialArgs = {
        			inherit inputs;
			};
			modules = [
				nixos-hardware.nixosModules.microsoft-surface-pro-intel
				agenix.nixosModules.default
				{
          				environment.systemPackages = [ agenix.packages.${system}.default ];
				}
				{
					age.identityPaths = [ "/home/aadamlok/.ssh/id_ed255"  ];
					age.secrets.google_api_key.file = ./secrets/google_api_key.age;
        			}
				./nixos/configuration.nix
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
