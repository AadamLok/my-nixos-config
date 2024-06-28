{
	description = "My System Configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	};

	outputs = { nixpkgs, ... }: let 
		system = "x86_64-linux";
	in {
		
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			inherit system;
			modules = [
				./nixos/configuration.nix
			];	
		};
	};
}
